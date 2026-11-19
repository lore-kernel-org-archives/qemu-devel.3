Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B08606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A2J0YvyL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyQH-0002Rs-FU; Thu, 19 Nov 2026 04:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTyQA-0002OD-Es
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:27:11 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTyQ8-0004mP-J7
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:27:10 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67dae7d3f7dso2328578d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795080426; cv=none;
 d=google.com; s=arc-20260327;
 b=q6Qkrbx2OYU+Bpho9VnGXzdSOf/bUS2GnUKNIpP9T9x0Wy3E8R+2rIsH0+uzwxtarl
 cBwqsrD3FYqgmMwTf6Oyb4OFwfjl4hQL7EyiuZEfvTSUn35G4liQ+tPEOGIxi7a2ZGdT
 n7/iVeoHJ4+wW2XvXqykWGh9qh5hzli6Bn69PuUHePQzYjmOwPLaFHTFcM9v26y77vqF
 lMutgRFOeBPCcl/Pyt61fIB+NbYIhSDd6LvR0mpOlb/WloqVo39Ka/5MuJ0Ay6jhvbeN
 ZWhVuy26OjZTPWwSSl/cKvoew1R+ppco1bGU+hR0uummP4YmzmANTMvB9pCG5416WM+f
 jLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b3j/f9gVwan2T+zAJs626goLS90f1nBLqdbtD3Yu0c0=;
 fh=q5zvxMDGB9U7FNSSYqzmDxKPGppqy4U3qG1HeIQ10SM=;
 b=iTTZD8Bsv/4zXXQSJJ69mm4c8nXxwvzXJ2wdpOwC69XYMAH1mogsASPOyWc8pA/Soq
 7cPIkKyFdz/U869vSW9XITwDNOcIE/VYguQ+l/vBfECRNrkOM1VoLmmhs7GYDHnMgW79
 LC3+MoIWLH+stqp/JJTrOrfOZETGIXGYlHGmBIo6SGhX+ZT2iAtmCcqg0xJRx2bbkYSb
 dKSv402KIzG3f4zU0DVcSUAeqH9rQiVrW121WJ1XcvWEMG53oohcucz+6XPJ/oKqqCo8
 04+yq3RAsmd8LdprNejjdCAkIkbZzd2usMQkguS2FN/bv6+AE14h6tbwQbSZruamyji6
 dkLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795080426; x=1795685226; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b3j/f9gVwan2T+zAJs626goLS90f1nBLqdbtD3Yu0c0=;
 b=A2J0YvyLNf54GqcIknpLbz5DnrMmtDo2lMgvLg6vajwWg6RbgiN+izeLVb5hqxGjpe
 +0m3aULuzS6CNnRa1PPwoVgM5EKNFyvaQOZEH5WDV+hEzbgQ+Z2KncgatIjljbtgZ2b+
 v8WJ75RYJ1wHxVafTewBOjDk8wjZ/6MHx2iI1ZTcDju7CKoTlo5RXiK/QPBwcVppMzEs
 TzrO+wjx+XVsdUtN1nCf3ta9JTzIXECpdfqO54xAGEf2/s0HfHFZ7TO6g+cpWUgVMRF3
 rFJ8tDlLF7SJIQ2BAzg6LhB24Xf4OnPN7QV0PRVreQcB4LNJ+Du4bPCZ/8rCfTw+8xrq
 jKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795080426; x=1795685226;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b3j/f9gVwan2T+zAJs626goLS90f1nBLqdbtD3Yu0c0=;
 b=kyPxMz/xkE4Kkogw/udPcSqWDj1Ng5hn6jtcFj2JDb33Y16VhjrNsC1cIODGa8yngh
 olRL6nTWLCeKps8bprYVKRkH+yp9X3dobjWvjKFwIV1n0pby/FHt1fxctfG50a5K06Gc
 zBIvyiedjmnqMjEV2liz4F+WxuOLpbZC1F+7J7CGUNTEFbGm30M7KFLP3ImehqFhBmXT
 vXb6vS0EBWvClfl1hKHrJUr9jH792qgzMpv6wf8Q3qYv9AO4sH2B57TJS22W7G28xhlb
 kRxIB3im9kieaYoz8H8grAXoQlJvUV+Yhj4U3s7Ex+xYXTR5JMjE2ZudW3xo78XK8Sg0
 CitQ==
X-Gm-Message-State: APuU4Z/NAj/HsbXCN1Bwz25tWxj0CxKdgrCQWDp/9t9dS4Dr/2/8bpZI
 EJpR7EQif3Z8+3/Y63uweM/JUgNnR6gZJGoXd+NupzyYn4jCXXg2p1xHJT7KlSpyuGPdlGblGnJ
 6oXuyucIgr14axvHc3NuL7BdFjlPn0ZKS04Xg5744Hg==
X-Gm-Gg: AZFdTZev1kWriRtqMpDoD/0X2s3u+b1RYMty8uTqhzwScq26wQkQGdS2MeD9Mi/AUl0
 2w4Q4aPGyILnx3BeN8hF75GlnlZR5FP97rd6y/ZGrzJJ8I3/DEhqDW4r+360hJoqxhePWM3Burq
 +/CImtHW0UVku1rrjK3Ln5CABqGNKsx5pdWVta1ZzvMlGU+Stkr0uhH6NxVwmxYj0ECz+Uh3V1L
 Kk+C7gocqtmakTfayHcIs00gh6XsJfxXD/bPYUeo7/DwI5TJcOJNrnlxjDNYv5tGNvmHjkMD+L/
 L4NwvGHVwb0LTy0wpiw3ceaWxZIDHoa5Rj88kipp/2isxCL0LxcB6+pLrjL6vynYOWPZ89Ntzwe
 a/NipscsBp3/CVSKpoyIRA78YpN+dzaU5s14NcYDOz1aAvvBTIkeuWAG4M8KGVNnE/8ezYR+pKQ
 V6dIAwvkxONOjPigDdfg/J
X-Received: by 2002:a05:690e:43d7:b0:67d:c184:8f8d with SMTP id
 956f58d0204a3-67dd3f1f423mr1214087d50.54.1795080426270; Thu, 19 Nov 2026
 01:27:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA9Ob8CsaufaAZ6jUhrKkxSfCkcig3ciG5LK_WCNCi14NA@mail.gmail.com>
 <de8cfd7a-9c43-44ac-baba-c8f892749dc4@eik.bme.hu>
 <CAFEAcA9BnWRnyMp4rswY1dxA4b5FQpQhK3YsGYGPXzwa-5YfGA@mail.gmail.com>
 <64F81A8F-4EC2-4147-B254-089A2D956264@gmail.com>
In-Reply-To: <64F81A8F-4EC2-4147-B254-089A2D956264@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 09:26:55 +0000
X-Gm-Features: AclHuK82oodAo3RYRz_HElXBGtHePl4QZ9JHxpT86KorrCbzvsGxE8d3euYy-RI
Message-ID: <CAFEAcA8VP4vf6=x6Np26FLYHBNXt2OzRMna92F6uJFvde=jCcA@mail.gmail.com>
Subject: Re: Who should be allowed to unrealize a device, and what can you
 still do with it afterwards?
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 18:58, Bernhard Beschow <shentey@gmail.com> wrote:
> Am 14. November 2026 10:37:09 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
> >One thing I'm not sure about is what unrealize is actually for.
> >Is there ever anything that a device needs to do in unrealize that
> >it could not postpone to deinit?
>
> I think this question boils down to what the difference between init() and realize() is. deinit() and unrealize() should be their respective duals, i.e. undo what has been done there.

The main reason IMHO that we have split init and realize is:
 (1) init can't fail, so operations that can fail go in realize
 (2) operations that depend on properties set on the device
     need to go in realize, which runs after properties are set

But neither of those apply to unrealize:
 * unrealize can't fail
 * there's no equivalent of setting properties that happens
   during the unrealize-and-destroy sequence

"Undo in unrealize what you did in realize, and undo in
deinit what you did in init" sounds like a nice rule, except
for the fact that we have no reference counting for "keep
this device realized', so there's no way for users of the
device to make sure that things they're relying on don't
go away if you clean them up in unrealize.

thanks
-- PMM

