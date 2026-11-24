Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046C606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M6lA1BbH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVuvi-0004yH-ME; Tue, 24 Nov 2026 13:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xVuvX-0004xv-OF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:07:37 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xVuvU-0002Lf-U2
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:07:34 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c515319dd89so585920166b.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:07:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795543650; cv=none;
 d=google.com; s=arc-20260327;
 b=oGHmOm+0Xz9zbVwrponevvx4por4uZ+5WjasKvFsNQjdXH8xrEjIH3n/mpBGHJo5nc
 exjIvfsC8LIxqmNumkn/kL1jBiudeaO4YIU1usCbXXmAHUqjYONPiblBOSPORaJ5Hrav
 WFW4TwNmDdcGMykzY3ViZ+WV8aEGD49x8jqWmwGWKbfpa31P8kClPiPlEAeAL7OfU+P7
 OdMfyXjvM35TrgqxfYgOrV9xkJzPCsbrzS/jJNoHvhXFfBWj8aGSUFIHDpLV7ZK8TL+u
 Rgfqkic6iUnk5wP00ubYrOx7FzhtN88/fju5ETPWNecLEvzbQluT69MHTKvfP4m0mFwn
 qM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=4u7GALdsL+RqilKgps99y1UtKvYWF3TKjvr7pzOuHOA=;
 fh=pENwWVD2uTWwt944qnDFwU5qLON1EIRn9w9DfU0gUbI=;
 b=Hhlro183TUN/Y7X18+3sOZGdIokDtcQ1FHtEx1QXS1MvRro/bJVPivs9C6nuW/CwQw
 HHX6a85SRvjVBIAChAoBR3x/8nOay7+LWQHv5NlNtXw3LPSMT7EqCzkolQSXxWh+ixRy
 7vlJDPqIz1fJnPITPE6NTIUS+4hJwagDc41MWYIZVfIGpzIJWwc6Dq9n3e/PKLVr07Ct
 UaWq/BBTkdHgDie2Mh3pDNUAMITJGWj15b6ffdXXyk+UZltpCukC0/PULHLdrheX2yyl
 0OkHeYgxLurUaaArqH9LVjn16mYwjuoMpMtYypRSiD7/TXvuGb7MbyvZxQwZp3iBdB9j
 49Zg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543650; x=1796148450; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4u7GALdsL+RqilKgps99y1UtKvYWF3TKjvr7pzOuHOA=;
 b=M6lA1BbHBIEF8ulFZKVZ5xDuMbpEYFCG1TuSPPRPVYCydMZkgAjdV7/FhOc9PMM9Bc
 o1sZ5LDuVT+iowQX7M0Rcsdd8+3dyq8I1u9wfdjAWbEcYPuKk2ZkwMK/wSmELH5PE9Tb
 5dmPxNRX2ga7WjlMKAXkeqvNXj3ytdfZ8I7UwWCaYYMuWi99OjpH3GC05EADgZaB1tOR
 jrGWF+P+kb/KWRezhqU2KvPWnS+ysgD4flcfdTf4DnGhynVsI2nQaOY3+B6tcZWpuw1h
 kc+QzLOB08IQBkFqLoBdTn1z9aGs+JL2yQWhBmZluYW2ac1AqJm0ZzEK+cRsq8wT8eu3
 ztyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543650; x=1796148450;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4u7GALdsL+RqilKgps99y1UtKvYWF3TKjvr7pzOuHOA=;
 b=VeCRwgsuct3dE243SgUT76QC2ieKzxpTvG1noU50qXi08oD7Kg0fAuWm76RvBnpHan
 1Kr/73LJwPHABjDAYkVOpGnUR2DWWMjYCFhytrzXXlc7XKk0Z2pq2pyQY4/xEHFKhr4w
 gViz/JRKxMxnhwbkNW2c+mJEq5X1kmuf9jjoqO/qAWRIR1UoJ78fr0J2GaA8gQ/9+tdc
 bY4MmfVwfajwWcC+yPjgWFL3G7OALH/5fth46jrxq2ubEDyNPXzNmuQH8sTwkIEAPtfE
 SEJh3ZHqwFvAEJUoERZ/+iThOYoOFAFQG65Zi2fqpB08nZA/8NJoFm0BN+Aq+K+EJgSQ
 zQXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHGvpXAkb1V9FQwgSwSXE8JgXw5bWNlb3nQIEBVSkumA29IKUMALuh4w5uT43MKxvbe/lgBQ2JjGlxL@nongnu.org
X-Gm-Message-State: APuU4Z8UUoluvGe7cAmXXbLSgKQlMrksV8bl0x36HXpg8a93ePLe/8oR
 BaHZcurjQhl6bswX+Y+FXKbvoyF5GDIU0yprrdChSK1CRhh9aUhUreH6jSK+GSkSQ26bOEfLVFY
 +7mP/+H/DAr/YCWgNTT6Tx+H13EABkYE=
X-Gm-Gg: AZFdTZdLRi59QbsVYiUgr1L30FFAv89OGqpUpgYoS7+wFxCilX5S/RVi/eZgHBSPGvR
 21r5X1jTjeDxcDAsxYdeMCyEJ8iUKbVlOlNBgXyGqVrqpLQ0dzoshU4FkyHEDEYGs9gJIlBtevi
 LrRD70fCoG1cR2fyXZhUuqTt/yxKWWbNNAbPuawnB3GvxVoAr14dw9tNFVgCHbgMxSmwaT+ERnq
 VwGZp3erG6jcZe25PaB9uvQQs0iBVl8qFbwXaHaZegKBJmKRS7Nadibx+81JFcNxp7nTMvka1Fo
 aMoL1KLDg1CI98EweSbSJDNeDjFbuf5NwlJG7zUNeWJW0m9anbGhPwY0HVMnk4Fr8Z36e0KLCMu
 NkEw/dcquDxipnOqygGvcVSlDneT/4yv2Bg4Dv+XJo8vh2BDw4DcVz+RiPB57s2chx+MM1HnWTt
 jbozwZdNkD8w==
X-Received: by 2002:a17:906:da0e:b0:c46:a72:e0c3 with SMTP id
 a640c23a62f3a-c513a84dd04mr1046689866b.16.1795543649913; Tue, 24 Nov 2026
 10:07:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Alejandro Lucero <aleszlucero@gmail.com>
Date: Tue, 24 Nov 2026 12:07:17 -0600
X-Gm-Features: Aa3M54q1jgtkbdH-6kR82EfIv3y27XyfJYMjs8qwQdn00cjNj0Ikv5SCY8IWEOE
Message-ID: <CAHDi9tqQCjQrinek1gua9L_1acUXSukbUYq-Temr=_OiVFSoVw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci-bridge: Convert pci-bridge to Resettable
 interface
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=aleszlucero@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael, Marcel,

Gentle ping on this v2 patch, which addresses Peter's feedback from v1 :).

Thanks,
Alejandro

