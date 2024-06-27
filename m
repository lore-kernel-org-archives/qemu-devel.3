Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF177C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMnY5-0005ne-BP; Thu, 27 Jun 2024 07:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sMnY4-0005nT-6H
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:44:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sMnY2-0000lh-7w
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:44:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-424786e4056so42715e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719488654; x=1720093454; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HsQ4ZRZxh8o4ChWO6fX/mSdbcAFATwqT4cBw2eqnJcs=;
 b=SBRn+PigUTTQgl2k9Sr0aAJbIjkD7cd49zbD6MfdAO3XtmxJhmabhwBPYNaH4ErIri
 j4vg+ZeQEVbzDvCca7Gkoi9wCzYfpZXucylo5YT6UrArTL9u69LnPX5quRWJNiSLoUCJ
 haGsQFvuRRAthmF4lQJ9weQ3lJcx13Ysq54FEQ/OorMUCH2M90D/3ZjQDVHM7YuCxMzP
 t5MSGO1sE8/pxOzSgS0zTKzaRfcgxqlpRA9MUPjMOHKaW2PL9MjqkW2joSGEAi40pjXL
 TBS5Gidh5jU7n7uJkgqAjAMAP7EuPN04eMAmDUEy2sX+Eak2yhgEIHWAgSoP2u1KLtUA
 OZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719488654; x=1720093454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsQ4ZRZxh8o4ChWO6fX/mSdbcAFATwqT4cBw2eqnJcs=;
 b=aLkk65omLjLaCIhvjZtIgcIqfQ533gUvcS4lh/OPc7rBqU7KPG5FkpAXllzmNg3Tqo
 /RgLMg6ImCbNOZSxuS4X7DUKbpIIV5kHaqesz0ZYctZ/JZgNreCmWxE90diifO3+nqFt
 zEfeRtKR2yKSN4pYFFQXDZIorkOLh2EihSo/EFw5gCC6WoyK/7gF/5fn4r9OiUvQghBr
 BMuOJ4WRv0QGo+LFpQX8qLnp5+hipx2bTR2BdGVA41i89S5FQb3r5DeebNgmfpiJSmJx
 SadOCOSRdtzQB7VE2QafrXSnsyOYxgr7YtQ9L75Nc+ARXO2vjsIMEACQOAz3myG44488
 e12g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVhZQ2LgOLXKTGg8FklOD6+pyzeY69kwfAkatWB4+NNUy+yTXpLRNcJy1KM6LWavqqoZe58/brnY25UkHxhONDy/VzXxE=
X-Gm-Message-State: AOJu0Yz1/GX811WK0qkFfr4j1y2lgmvqnlSNIWOUOpJFmqv5FrLy9fNg
 YFIh3lLnPY75vLPOroFfAGXTA+WEwFDlKCT/fpI9PA87XgZOR6eVEw10UenDhA==
X-Google-Smtp-Source: AGHT+IH9ioBTJIjo58fz7MfO2NxK91hj4b9tbCZakj54bZeI1sDVjaMfHLNrNBaFVOP46FfbQi5ziw==
X-Received: by 2002:a05:600c:3ba9:b0:424:895c:2f97 with SMTP id
 5b1f17b1804b1-425641c5e76mr1389145e9.3.1719488653962; 
 Thu, 27 Jun 2024 04:44:13 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564b68511sm22946925e9.19.2024.06.27.04.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 04:44:13 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:44:09 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Julien Grall <julien@xen.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, jean-philippe@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 18/18] hw/arm/virt: Set SMMU OAS based on CPU
 PARANGE
Message-ID: <Zn1QiRQuVwNCkvss@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-19-smostafa@google.com>
 <0b40423d-cf19-46a0-a86f-aefc5c7b02b1@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b40423d-cf19-46a0-a86f-aefc5c7b02b1@xen.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Julien,

On Fri, May 24, 2024 at 06:22:12PM +0100, Julien Grall wrote:
> Hi Mostafa,
> 
> On 29/04/2024 04:24, Mostafa Saleh wrote:
> > Use the new SMMU property to make the SMMU OAS match the CPU PARANGE.
> > That's according to SMMU manual ARM IHI 0070F.b: >      6.3.6 SMMU_IDR5, OAS must match the system physical address size.
> 
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   hw/arm/virt.c      | 14 ++++++++++++--
> >   target/arm/cpu.h   |  2 ++
> >   target/arm/cpu64.c |  5 +++++
> 
> When trying to build qemu-system-arm, I get the following error:
> 
> [1/3028] Generating subprojects/dtc/version_gen.h with a custom command
> [2/3028] Generating qemu-version.h with a custom command (wrapped by meson
> to capture output)
> [3/3021] Linking target qemu-system-aarch64
> [4/3021] Linking target qemu-system-arm
> FAILED: qemu-system-arm
> clang -m64 -mcx16 @qemu-system-arm.rsp
> libqemu-arm-softmmu.fa.p/hw_arm_virt.c.o: In function `get_system_oas':
> /home/jgrall/works/oss/qemu/build/../hw/arm/virt.c:259: undefined reference
> to `cpu_arm_get_oas'
> clang-11: error: linker command failed with exit code 1 (use -v to see
> invocation)
> ninja: build stopped: subcommand failed.
> make: *** [run-ninja] Error 1
> 
> I think you need to provide cpu_arm_get_oas() also for 32-bit arm (I guess
> it is implemented in target/arm/cpu.c).
> 
Ouch, thanks for testing that, I am currently reworking this and migh drop
this change as Eric suggested, but I will make sure it also builds for arm.

Thanks,
Mostafa
> Cheers,
> 
> -- 
> Julien Grall

