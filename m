Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77326E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0NY-0006D8-29; Mon, 02 Mar 2026 05:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vx0NW-0006CN-0g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:19:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vx0NU-00070h-AC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:19:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48318d08ec2so89515e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 02:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772446790; x=1773051590; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cozeOcSo5NYB1Fwv5aq+MkvcKJ5E/mUbK5yqyoQkrxk=;
 b=h5rVU7jEc10bhXnRKv6qlFuppojIfR/Jafqhpc8wlSiVjsWVu+Y2Uhf3AFPLc6Ze/q
 sFC8zdrvOiEH/NHV2CvWtvkOd8eRfguTG05MdIw2ereWb0r5LkZKp00RiXe4V0UK8fTp
 /xd7WX0rRErMApRKsi0mxl9zNEnmm+cWOZBofTqCNv6DSJLFrxbw632aJRIn6rf3MscN
 0X9ZPdq2//3YSV32fVkWlCBDnC50nSsIdPNChmejJrjoS40edfpA4/mKCmdKQC0tD5cZ
 wlZ0KYOjuAqto7bg6tA1vRofIlvIDau8Q7ZlMmR77k97oVrKgHnRnHxDj35jNBzvtJmT
 CIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772446790; x=1773051590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cozeOcSo5NYB1Fwv5aq+MkvcKJ5E/mUbK5yqyoQkrxk=;
 b=xP2lmtD4ggLsIHC2haDfwgoL/OvN1b4E2q5T0Rjk+DPuxS+8RVATLxKSCMj/HdgNGR
 4yLhm53BKzcL6PCoLZe1UuiXX0arK+iWEG1vRrE4zSFIoVwAJCyg9nu7mRobQayX7KLY
 Pjj2PnLiHMgvu7qanTsB1BbtXvF6uSwaXwpG6IYIe6rGlnTszjXRqzDb6I6vK1XL5Yxp
 VxoLNbGaeqkcCDL/E4qaP0wtm0mhfUiZ4FXAzR/P7tYc4akJcG6oEnXHA/NMyMo8AtIG
 PjYR37JHF0Gd7/DG1JKbet8QGIptvSHdynzzbmbultAqjyCpbjwWjUXOVLGt4xMs/y7+
 p8pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbRB7iOgEuVt1+H1oVoBQyhd65TNLGSkOVH3MBrgvo4Gu+vsEu1yXPKCv/4omwlxYj9LujtusnViTS@nongnu.org
X-Gm-Message-State: AOJu0Yzg1xE0J6vq2/nxkBmsuerXDdz5mTlOAVvIMgt+bEml/oJAstUq
 ySDhhQZotgFA/70SX02VmDI7lJulNqQl3mdJSA2sKucpjQT0iJ2ylqxqpjhptucV/Q==
X-Gm-Gg: ATEYQzyTRAs4AZjHEnAW02rhj8p47byPuBc8IiQ99iH5jmx8+ebBvfAUYiyL2voaT+2
 xnlMxN5eVLzYCp27+Kf6eigq7vRn002aMV2RLQtgYmQtboZqUIVwJGSqPBztqVpHdKuVAFBSpPF
 rhaRcP5naBeixjP7hurPKAWyZpgTS9MV+bJGtMck3l1OOr5F9iE+4DnD2LKRVrFTDq3EVBJDGfu
 b6BrwBWTAyVf0e3S/OJ7Gvez4cSt/v7h6DH4z4eC11fDRmTZh5VvzWjr7ZQM13dN/p0auoX20p+
 N3jW1tVQuPxdEuGiAJFlswTVGxbs6veSIuDSUT7MLnxMiSfeC2a82pm+VDIXpNhLdF4hss0yWLC
 xhm2zhTOHbVtBPaIA0VxqRAqSaEKPnGl8FiqHvQ3whbqrVerobAlnO/PiWTUIMxhudsDovNsQoN
 NWcpgPm19afRlJ0WIFmsbaQ7+/Qch3tgocmnJMoPRGjhkhY/7rAvJ9UIVFbhax+VCf
X-Received: by 2002:a05:600c:8b2f:b0:477:86fd:fb47 with SMTP id
 5b1f17b1804b1-483ce5e2ccemr1948505e9.8.1772446789520; 
 Mon, 02 Mar 2026 02:19:49 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df9fsm466954595e9.13.2026.03.02.02.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 02:19:48 -0800 (PST)
Date: Mon, 2 Mar 2026 10:19:45 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 06/31] hw/arm/smmuv3: Track SEC_SID in configs and events
Message-ID: <aaVkQdanf4KhROna@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-7-tangtao1634@phytium.com.cn>
 <aaGsltcRyTu7j1tU@google.com>
 <df545e5d-0380-49bd-97f1-5b7b9a4259da@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df545e5d-0380-49bd-97f1-5b7b9a4259da@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 01, 2026 at 09:53:24PM +0800, Tao Tang wrote:
> Hi Mostafa,
> 
> On 2026/2/27 PM10:39, Mostafa Saleh wrote:
> > On Sat, Feb 21, 2026 at 06:02:25PM +0800, Tao Tang wrote:
> > > Cache the SEC_SID inside SMMUTransCfg to keep configuration lookups
> > > tied to the correct register bank.
> > > 
> > > Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
> > > and event logs always show which security interface emitted the record.
> > > To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
> > > identified as soon as an event record is built.
> > > 
> > > Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > ---
> > >   hw/arm/smmuv3-internal.h     |  1 +
> > >   hw/arm/smmuv3.c              | 20 +++++++++++++-------
> > >   hw/arm/trace-events          |  2 +-
> > >   include/hw/arm/smmu-common.h |  1 +
> > >   4 files changed, 16 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> > > index 866d62257e3..a1071f7b689 100644
> > > --- a/hw/arm/smmuv3-internal.h
> > > +++ b/hw/arm/smmuv3-internal.h
> > > @@ -274,6 +274,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
> > >   /*  Encode an event record */
> > >   typedef struct SMMUEventInfo {
> > > +    SMMUSecSID sec_sid;
> > >       SMMUEventType type;
> > >       uint32_t sid;
> > >       bool recorded;
> > > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > > index 2c107724e77..3438adcecd2 100644
> > > --- a/hw/arm/smmuv3.c
> > > +++ b/hw/arm/smmuv3.c
> > > @@ -148,9 +148,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
> > >       return MEMTX_OK;
> > >   }
> > > -static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
> > > +static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
> > > +                                       Evt *evt)
> > >   {
> > > -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> > >       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
> > >       SMMUQueue *q = &bank->eventq;
> > >       MemTxResult r;
> > > @@ -178,7 +178,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
> > >   {
> > >       Evt evt = {};
> > >       MemTxResult r;
> > > -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> > > +    SMMUSecSID sec_sid = info->sec_sid;
> > > +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> > What does this defend against?
> 
> 
> sec_sid is now taken from SMMUEventInfo, so the assert is to catch
> programming errors early and avoid out-of-bounds bank accesses in
> smmuv3_record_event.

Personally, I don't like this kind of defensive programming, someone can
argue we can add such checks anywhere.
I believe we should definitely know the possible states in the software
and add checks needed at guest inputs.
But that's also up to Eric.

Thanks,
Mostafa

> 
> > 
> > Thanks,
> > Mostafa
> 
> 
> Best regards,
> 
> Tao
> 
> > 
> > >       if (!smmuv3_eventq_enabled(s, sec_sid)) {
> > >           return;
> > > @@ -258,8 +259,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
> > >           g_assert_not_reached();
> > >       }
> > > -    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
> > > -    r = smmuv3_write_eventq(s, &evt);
> > > +    trace_smmuv3_record_event(sec_sid, smmu_event_string(info->type),
> > > +                              info->sid);
> > > +    r = smmuv3_write_eventq(s, sec_sid, &evt);
> > >       if (r != MEMTX_OK) {
> > >           smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
> > >       }
> 
> 
> 
> 
> 

