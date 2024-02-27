Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC67C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reutF-0001zl-SC; Tue, 27 Feb 2024 05:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reutE-0001ys-HI; Tue, 27 Feb 2024 05:40:48 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reutA-0000I8-PV; Tue, 27 Feb 2024 05:40:47 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-365138d9635so14085915ab.3; 
 Tue, 27 Feb 2024 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709030443; x=1709635243; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjMRO3XZsQh6m/JqvwwEiXBbkgypITmT6/qhO1w0rSs=;
 b=VnZKBk8H2Z2bhq5YKpPOdhKP7LMr4/3BB3ZLthy0mR6XF1hVCNKMvM6oZye0qOIWcC
 /s+iGESQagcnPtI6ZU3ETQ4BLfqDpvL466Fe6cBM5LufKdbcD5THkkMzAKehnHjWHRo1
 HWWeiqFSsDDI4CnB9qVmoFsNYW/xfOqNJUFNe8/9fuXyLiiE4717BgyDGtEXMxQsqX0C
 fw0Tvr+cntxgBPjl2Phl6Ayxs6cTdMMSMw+e2IVh+X4+3wS2Pmh4/exSWXT78FHxv9bY
 T9NOGKUcSr4KxwEHgnY6JhSoQXu2O1UucQAKyCBPy/ja/02fPeSQRcQS7myAFUY+kOhG
 fvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709030443; x=1709635243;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yjMRO3XZsQh6m/JqvwwEiXBbkgypITmT6/qhO1w0rSs=;
 b=P5Pw9m4/X0NwjXeYJJhvJv0pghefKE679/q/L9O7CjoSy8v0OIFVqLwJV1faUY/K1M
 hvUoyeGrNfRL9qQKTdVNy+6FleHqkRcpWdLYbABeaS10DAcrqydBpHCAzM/rijKbQSTX
 387SxTKwyHv47zkScteVzoLYkLN/6onfQrxFF47+3dJqP7E6bL0bzKmglsD3uVWntk+y
 10t0ipuGZUKgxfxlK0q9nYhZI8y+5h8gAC/FuJf3q9IaNxBtoyJHaAxH61kCEJLZKSCI
 sRecuvyWQ59c7o1bb+srReppDbMfRDnJDYehgbLYrE5yn97EzeL1DfCC9SQ4aoyMF3++
 nk4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdulb5rPeW13XaKiViacCl9iCRiD+F4zMoYSs57/5pn8JnRdSdJoBLcvwMbN8nU7qWaW1J/B6J2vZe+/hiPtfXpL4aQKZjfshV4w2NqtyAWAlL9SB4BId9ZJM=
X-Gm-Message-State: AOJu0Yw7OytS/Z+Ggsz4Qd7vJyLX+FMIjbCBIGN5PAKsihsRLqNcasSd
 mMQqRTJF1AELCz/DJkEjbROQyfgr0iWE2cGGiOQgbxUNJpmdauna
X-Google-Smtp-Source: AGHT+IG6Z6fn+sHBjIpoLk2uwmnxu74gKl4SLcqFpW7kQTJgU4UHRCQpvG30ms3kN4okGEncfIElbA==
X-Received: by 2002:a92:dd11:0:b0:364:2328:22ba with SMTP id
 n17-20020a92dd11000000b00364232822bamr10088620ilm.12.1709030443101; 
 Tue, 27 Feb 2024 02:40:43 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 hq18-20020a056a00681200b006e465504e14sm5562326pfb.2.2024.02.27.02.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:40:42 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:40:36 +1000
Message-Id: <CZFSQ7RA8KH3.ACBBLHG82NDV@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 04/15] spapr: nested: keep nested-hv related code
 restricted to its API.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-5-harshpb@linux.ibm.com>
 <CZFQHBO2FUX6.30O1PDW79JW97@wheely>
 <992d980a-da74-4c61-843b-888facc5f813@linux.ibm.com>
In-Reply-To: <992d980a-da74-4c61-843b-888facc5f813@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Feb 27, 2024 at 7:45 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 2/27/24 14:24, Nicholas Piggin wrote:
> > On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
> >> spapr_exit_nested and spapr_get_pate_nested_hv contains code which
> >> is specific to nested-hv API. Isolating code flows based on API
> >> helps extending it to be used with different API as well.
> >>
> >> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>   include/hw/ppc/spapr_nested.h |  4 ++++
> >>   hw/ppc/spapr.c                |  7 ++++++-
> >>   hw/ppc/spapr_caps.c           |  1 +
> >>   hw/ppc/spapr_nested.c         | 27 ++++++++++++++++++++++++---
> >>   4 files changed, 35 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nest=
ed.h
> >> index 2488ea98da..3f07c81c3d 100644
> >> --- a/include/hw/ppc/spapr_nested.h
> >> +++ b/include/hw/ppc/spapr_nested.h
> >> @@ -5,6 +5,8 @@
> >>  =20
> >>   typedef struct SpaprMachineStateNested {
> >>       uint64_t ptcr;
> >> +    uint8_t api;
> >> +#define NESTED_API_KVM_HV  1
> >>   } SpaprMachineStateNested;
> >>  =20
> >>   /*
> >> @@ -103,4 +105,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
> >>   typedef struct SpaprMachineState SpaprMachineState;
> >>   bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *=
cpu,
> >>                                 target_ulong lpid, ppc_v3_pate_t *entr=
y);
> >> +void spapr_nested_init(SpaprMachineState *spapr);
> >> +uint8_t spapr_nested_api(SpaprMachineState *spapr);
> >>   #endif /* HW_SPAPR_NESTED_H */
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 97b69c0e42..51a1be027a 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1376,7 +1376,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor=
 *vhyp, PowerPCCPU *cpu,
> >>           entry->dw1 =3D spapr->patb_entry;
> >>           return true;
> >>       } else {
> >> -        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> >> +        assert(spapr_nested_api(spapr));
> >> +        if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> >> +            return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> >> +        }
> >> +        return false;
> >>       }
> >>   }
> >>  =20
> >> @@ -3443,6 +3447,7 @@ static void spapr_instance_init(Object *obj)
> >>           spapr_get_host_serial, spapr_set_host_serial);
> >>       object_property_set_description(obj, "host-serial",
> >>           "Host serial number to advertise in guest device tree");
> >> +    spapr_nested_init(spapr);
> >=20
> > I would maybe make this init a reset instead, and then it could do
> > the hypercall unregistering as well? You could rework that part of
> > it into patch 1 (or reorder the patches).
>
> If we do unregistering here, we still hit the assert during
> spapr_machine_reset which tries to reapply the caps and thus re-register
> hcalls. Also, We cant register hcalls in this since the caps havent been
> applied when init is called here. So we can do as you have previously
> suggested, reset in spapr_machine_reset based on caps applied.
> Let me know if you think otherwise?

Not unregistering here, I mean make it a spapr_nested_reset() call and
call it from spapr_machine_reset().

If you call it after spapr_caps_apply() then you don't need to do the
hcall registering in the caps functions, just do it in the
reset.

Thanks,
Nick

