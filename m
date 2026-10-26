Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB784606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AtZ0OVjy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLGjp-0004sW-5g; Mon, 26 Oct 2026 05:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLGji-0004rR-7F
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:11:23 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLGje-0004FI-Rc
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:11:21 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0cf2c0785so23592037b3.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 02:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793005876; cv=none;
 d=google.com; s=arc-20260327;
 b=Qodw/BrVz2n1lzaU7m69ooIXz7soWSvtcyppxvRs/KS/Kx/6jS9Licpl/X13Nwm630
 9PHTREXXj3IRTXdlZWbTlV94tLkzRddVtAUKhqkUqXTLAPt5fS/WvwYNdI5UCZtO0c0R
 SQt7P2u3/Ukd7tb2LtNS4wlgaKXeLA2R4yN85Uizdx0gdeC6u3C4s48j68UhxZW/Ppz5
 XgdaCKmS7PgtUZF1uc5ENGv583Yh8b4NvrLaAeM24PDkNoZJwh89qx1I4o1D2M1K/MDx
 lByI+5y4ZRr/Ibpd1IpBs+iLPZbYR2YRAH/ef6qPZksX/96pRa7vmD0G3xvCKH8nW6Zb
 Yx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eDeNvKeCV/tDlmDcxXb6YryVSIxCk02/d9zxIElrqhc=;
 fh=vPJYHFjiYVPFwgN3DHyHW8sDW+Hs0owe6lEF+QM3sHY=;
 b=VN3hNuOcKagjhMvL12kF0kZyK9R50Pe6fIRuwyw4SZd7B2lnU5D2QHzql919/KGE14
 0+YO9PWaUkfM6upsdvKFWyv4N9qRWlp1QPhGsoFC7v+Qz3OsaiECKjFW0kfYoTvmFjw4
 jid6TsnPpUGcIl/2AYANUudLh5tWGzbyPAky0mEllG6/FOnQnOsxRsNhmXiZmWLlPuZ6
 mtSikBPew2+JKstTum7LotRX7oY3LdGENZsy0XUVS/h7htV225H47Sor8uoR4dcfNrOW
 aZ6hCLAgYzH+4HSUZOcWcs2s7s/gpGzwJ6DIWYE4W2AJTewJ3SaqqEmFRE/8bjx5sCGu
 CPlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793005876; x=1793610676; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eDeNvKeCV/tDlmDcxXb6YryVSIxCk02/d9zxIElrqhc=;
 b=AtZ0OVjyw7v/QgLZfv+9rJ7awJgT8wCp9U64rvTERFlw3QyAUoBD5761kFgdyNgGye
 vJfX8eysb3lKKdpCISoLgAuMF/N8/qQJceLlyhWh+jPWnF+hSRHDzC+pGrAM2/ksurh9
 xeNlFINbqgiXX/doLivlpYzZkmyF+Kv03VEzRdqu0gA0bhlN5iR19GLAY4/o1OhbMPWf
 nGIwvh9WyeWZ9lxU9bcgg6WU7MqWwHjcyvUm3kWVXxZ6X2pfeyiVqRDJBJH8vP2813Jg
 6BTA2xfB6jAHbuUq9smYr1VLtUiX/J6DLtuUcdwWOMHHNUEz3oFKZlqdCaI8PyBM0lg1
 XtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793005876; x=1793610676;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eDeNvKeCV/tDlmDcxXb6YryVSIxCk02/d9zxIElrqhc=;
 b=fPKI3E5+ko4iDChfOsNANH1JfuKot9wft71feSKG/C1MWV+z793bG3y/lE3/oCwkQE
 wEIdUwQbMmtAWstEYOQU7YBmLWOJhOOG2hW9zYRugZyM2iJLCu8kepmbcxWatefZnrQq
 8s+8R6tH/YDcfYYTlaZCzjBDvGvjyNAoCDf6BjfiTbaF2qLVbS5vdRaG5sgwx1KF0LW5
 paM9DUcxtJpObp1oAhDTJh0gp7ZFJjCN/Q/c6LujO+wcBrlDS6f8DdPSmQJKk9+tdTHP
 7+XRjpOXePKCCx6yLPob/7blSXl7He7MxMRQrRU7B0DQQjCtZ2Plw1DJXrWZgx9ITXPu
 9myg==
X-Gm-Message-State: AFq9FYKbL1abGjm9pMSKYHPz0I6e1oMfzvI9pdoPGNRsK5J8B4X0j9qG
 k5wNnfCtjFgkJFX7G9Yn83AWjhsjl4EH+F4GvHbrG4oJVlpjLeq6Ed36vS/zgOUNWOl0h78Jze4
 SUB41VtgMlYqC1K8CoqRExXQ/IQ/goaMexiBv+W/2Nw==
X-Gm-Gg: AYBFou0D0UBPieHUYMv2EySwKxSTDjrFnPYMumVnP/0LTpwIjWZ5Udd6F8b5ZnTnya/
 2+59892xCZ/JL0z8zvpXXCrwICRxJSl31jj0FTn10SpkgKh0q9I9LjlJVIsqdg13SdN8RbC4eDR
 /mBhW4KpUllGUx+hDlnZ/G9FRPNXjPiBbQnhyOL5RCOrCAtys0ph294SNhXQUBrmjX1wbyUdLxS
 AwwxIvrfL1iIFqXS3JcHIY2Hen/OTPpNXcP1017+D9XFXjR5R40r89FBfdT01Kn0sTtZKWv/LWL
 J+NPcnj4Emfb9EIIjwXXLBt6Mx2BXaClCSbviJzrAn1YZsVdVr5+MjcPhQ/sLaF9MD2Ul/Gc0A+
 3Y/WzhrxbMhrEvtjBBw512AQoLm86fZMH3ClvoiSPRXRPSswMuLlzfOmeg1GKcu4T9PC0tu7T1a
 i9Z/M/0MBlJDYNY/8emw0R
X-Received: by 2002:a05:690c:4002:b0:8b1:6c0e:35b6 with SMTP id
 00721157ae682-8b16c0e748bmr25192297b3.32.1793005876356; Mon, 26 Oct 2026
 02:11:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 09:11:03 +0000
X-Gm-Features: AclHuK8YBZ8HpxYPF-pfENIyDwU4UEmGuviAZeOwc_Jni72YR74eL-LE_066aBk
Message-ID: <CAFEAcA_7CsFhHhj629tXdPkfz=a0NmU24zMOaTuoznf9VEF36Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Fix OOB access and overflow bugs in display, audio
 and SCSI device emulation
To: Tristan Madani <tristmd@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, hpoussin@reactos.org, arikalo@gmail.com, 
 balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de, pbonzini@redhat.com, 
 fam@euphon.net, mark.cave-ayland@ilande.co.uk, kraxel@redhat.com, 
 berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 at 19:14, Tristan Madani <tristmd@gmail.com> wrote:
>
> This series fixes eight security bugs across display, audio, and SCSI
> device emulation backends. All were found by manual source code audit
> and reported via GitLab confidential issues (since made public per
> maintainer request).
>
> Summary of fixes:
>
>   - Patches 1-2: ATI Rage128 2D blitter integer overflow and
>     width-vs-stride mismatch leading to heap OOB writes
>   - Patch 3: G364 framebuffer top_of_screen OOB read
>   - Patch 4: SM501 framebuffer/cursor address OOB reads
>   - Patch 5: NCR710 SCRIPTS engine infinite loop (CVE-2023-0330 variant)
>   - Patch 6: TCX blitter source address OOB read (host memory disclosure)
>   - Patch 7: Artist display off-by-one OOB read
>   - Patch 8: GUS 16-bit DMA heap and stack buffer overflow
>
> Each patch includes a Resolves: tag pointing to the corresponding
> GitLab issue. Patches 1-2, 6, and 8 are Cc'd to qemu-stable as they
> fix the most severe bugs (heap OOB write, host memory disclosure,
> heap overflow).

Have you read our AI policy?

https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content

-- PMM

