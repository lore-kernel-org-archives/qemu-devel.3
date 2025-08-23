Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18551CA0EFA
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 10:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uplit-0007pp-5w; Sat, 23 Aug 2025 06:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uplil-0007lc-OT
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 06:43:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uplij-0005dy-Vv
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 06:43:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-459fbca0c95so40695e9.0
 for <qemu-devel@nongnu.org>; Sat, 23 Aug 2025 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1755945816; x=1756550616; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AIOyF8h41AAN01tpKcBE3Z7P7M8oJ+cDqLaohjVDWgQ=;
 b=m82lk5yzCgQcX8Miv6riAhauGglp07MHxF4gQVto4tpQ2t1FOxqqexC99lyjO4fUkJ
 uy7iKaYvgc4dxR00/Xh8Z+fXonF3+73yzjR+qUWqt+sB0olocyL17om44+6UygzbgVQM
 /hjSiB4prU2zI79QeKyF8LZBjb8N4z7WHrWsLC3AAWTZrGyoLe0sj0uhiodgXySEhAOL
 X119t2AtbaSgMPj1XmphWEVGdJaSw1KDIttf8IVJn5lizMxWFLsP3wCswQ11vJotKF81
 B1eRyzeHWKvn3Eqvy7er8NjkChPFQu102dyLP89/SvQH1WLHdEfmz5llq/X7GxFS0w0q
 6wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755945816; x=1756550616;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AIOyF8h41AAN01tpKcBE3Z7P7M8oJ+cDqLaohjVDWgQ=;
 b=e6QLjOmfZM641Dob6RdTJ50OlfncJbSS9mc1ny+e+Smz07xoDcXpDm46eGSmJvqLlC
 1fju9p3ASAx+o0DLbSvwkmBm1f/86JjPMkXOtZtFKbTt6w7U5BA+Gevxpo0isKw2IFt4
 fOoawsw6g+bgAg+7URCK4e0cxMWz9Et3wXjmP9Ci7h7r9yxQFCgX7aLZB8KP4E2Bmd4+
 F/+eOUtXTUYJcojIXdLfMDzQ3qvzs06Vt0LBXtajaYDcC1ERDAvIVR5SHy/WIn5mfx4e
 ncpAkS4MZCwj0h4V+7/ZrmHxY+0KFLZAft4ao6i797pwP2FlStfpHEK+1baPp4Pi7NEn
 JJYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhPxEOaLHWdiK+QJ2bnD9W20+SvRVhx3K9AtqDsqlqiD4Pd5jDXg7iOnRCzWIsG4VXN27DpmLvYCHE@nongnu.org
X-Gm-Message-State: AOJu0YwFOeT+TzmilQnUDm6tskp+HNp2EVeEa7FghTjOryVOlcPMKK5F
 JoQtZpR0FSkAdhbguevplfgSzt3pTyp8P1/GHOSWjCZPh8c5YBEw4YnowBwND9XJgQ==
X-Gm-Gg: ASbGncvdOu58HZlVqg/1Dtij5v+sBIUbYmQ0wNCxdSE6kK0Wc11Neq1Z8TFvH8gcQeM
 YdBmSA27tzJysLjhUPTcH1bXoebASweDUuM00mt2EaDhbO3DdNM7so/C2TZ6QTHetY2uW1aM8XP
 WidqDlev3OnRH6GqWqxpGlrW2Ait/0j7IWybkn8pqn+zGKN6ZXG0PmV/B/KSSnGVxmRnOBl915G
 GeuDJ31IcnjFWI19yf0dBnt++K6LW3Oe56o5MfbV5cb59RMl4NIPicMdcVnJUX3Xq3BAMcjxK+x
 744Q+N45a+yILORHp7xBft99USW2SD59erPq7537RH3NK1IRoxAyRwUScZMM8uJVgxl67J5v5lp
 8c8Kn8DnrVy/X2/om7HVBKs2WEo4J8g0oU1+P6kLduVfgpPqra9VUhLacQW8L5SHL/hY=
X-Google-Smtp-Source: AGHT+IFphaBK0vNlYF3H3FCXhE4KC+N388B6IwsWD8PalUoQWFFaW9jKmiIrMTqLkTT7NwtCR63z1A==
X-Received: by 2002:a05:600c:8217:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45b57c2981cmr1178885e9.2.1755945816345; 
 Sat, 23 Aug 2025 03:43:36 -0700 (PDT)
Received: from google.com (248.27.205.35.bc.googleusercontent.com.
 [35.205.27.248]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70ef55bddsm3105521f8f.22.2025.08.23.03.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 03:43:35 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:43:32 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, jean-philippe@linaro.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC 06/11] hw/arm/smmuv3: Plumb security state through core
 functions
Message-ID: <aKmbVIGWry9nH8j8@google.com>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-7-tangtao1634@phytium.com.cn>
 <aKOa8KwAcm6hhAXq@google.com>
 <7b8acb9a-e3fe-461b-8495-42c7501a6a80@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b8acb9a-e3fe-461b-8495-42c7501a6a80@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=smostafa@google.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

On Thu, Aug 21, 2025 at 12:25:40AM +0800, Tao Tang wrote:
> 
> On 2025/8/19 05:28, Mostafa Saleh wrote:
> > On Wed, Aug 06, 2025 at 11:11:29PM +0800, Tao Tang wrote:
> > > To support parallel processing of secure and non-secure streams, the
> > > SMMUv3 model needs to differentiate between the two contexts throughout
> > > its core logic. This commit is the foundational step to make the code
> > > security-state aware.
> > > 
> > > An is_secure flag, which will be used in subsequent patches to represent
> > > the transaction's security state, is now plumbed through the main
> > > processing paths.
> > > 
> > > This change is purely preparatory and introduces no functional changes
> > > for the existing non-secure path. All current call sites are updated
> > > to pass is_secure = false.
> > > 
> > > This refactoring paves the way for upcoming patches that will introduce
> > > separate TLB entries for secure transactions and enable a fully
> > > parallel secure/non-secure SMMU model.
> > > 
> > I think it’s easier to review if this patch was split (STE parsing,
> > page table handling and translation, TLB invalidation)
> > Also based on my comment on patch 2, stage-2 handling doesn’t seem correct to me.
> > 
> > Thanks,
> > Mostafa
> > 
> Hi Mostafa,
> 
> Thank you your suggestion.
> 
> You've made a very good point. This patch is indeed too large and tries to
> cover too many different areas. For the v2 series, I will break this patch
> down into logical parts as you suggested (STE parsing, page table handling,
> etc.).
> 
> I also acknowledge your concern about the stage-2 handling logic from your
> comment on patch 2. I have sent a separate, detailed reply to your feedback
> on patch #2 that outlines my new understanding.
> 
> And as you commented on patch #01:
> 
> > > Inside this TCG VM, a KVM guest was launched, and the same NVMe device was
> > > re-assigned to it via VFIO.
> > > Command line of KVM VM inside TCG VM is below:
> > > 
> > > sudo qemu-system-aarch64  \
> > > -enable-kvm  -m 1024  -cpu host  -M virt \
> > > -machine virt,gic-version=3 \
> > > -cpu max -append "nokaslr" -smp 1 \
> > > -monitor stdio \
> > > -kernel 5.15.Image \
> > > -initrd rootfs.cpio.gz \
> > > -display vnc=:22,id=primary \
> > > -device vfio-pci,host=00:01.0
> > > 
> > > The KVM guest was able to perform I/O on the device
> > > correctly, confirming that the non-secure path is not broken.
> > I gave the patches a quick test and they seem to have broken my
> > nested setup, I will look more into it and let you know what I find.
> > 
> > Thanks,
> > Mostafa
> > 
> I'm sorry to hear that it has broken your environment. Please don't hesitate
> to share any details, logs, or reproduction steps when you find them. I am
> more than happy to help reproduce the issue on my end to get it fixed as
> quickly as possible.
> 
> 
> I would be delighted to hear back from you on any of the topics we've
> discussed, as any further guidance you can offer would be invaluable.
> 

So far, I couldn’t repro, I remember getting permission errors, I will
keep the patches in my stack, and will let you know if I hit that again.

Thanks,
Mostafa

> Thanks,
> 
> Tao
> 
> 
> 

