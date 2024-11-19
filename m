Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D941D60CEF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 05:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDGME-0007ZI-4m; Tue, 19 Nov 2024 00:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDGM8-0007Ys-Qb; Tue, 19 Nov 2024 00:00:52 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDGM6-00030b-8s; Tue, 19 Nov 2024 00:00:52 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso4490405ad.1; 
 Mon, 18 Nov 2024 21:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731992448; x=1732597248; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTTjBKiLGOZmzbOjtDS4jyxv/LaUSp0pyxKAOZ+WEwI=;
 b=crWh+yayhMIoFHH65BpEvYRyysdZpVLp06owuPM+PMtYfWLRPpLsmcbDUgAu9GTtS6
 6Y0u86wTbPcLYC0n1Yy4IDz4HeMamMNp1Y0x3N1LxuKYUGhVxkA7DqqeWoANou4IsSbg
 31+ZRI6VhKw5IxaCIY6zrkD7CfZws1gbLbTVtyS+suPhWKEyH6Oun+ZHWqYHGXRDr/UN
 4TRJWXtUjXwpt/WRtwYbS/oPquLc0vHkn+J1obz5Jjin04BzMQP4yw5kidPsRi0CqnGR
 yLzu+eLjlgsfOkE/V/Gr0Fl17wPonWOsoao5xtwpUw/znYneFAa3WKIv6DPGQiofPfho
 kXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731992448; x=1732597248;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WTTjBKiLGOZmzbOjtDS4jyxv/LaUSp0pyxKAOZ+WEwI=;
 b=MvmlxN5rtfxvATZ5KZJoySHTAwLHCjqylyqBYCrkAmnhRe7YdFO3mWtBLR/5ceCBMY
 Xfg8YnC8zgFFfBR+UwCbcY9SYi7BsC6G/AssBmQligBwzd9sP+dZpFjSW5F1m3mg5l/Y
 YbB70rCxiWgTzHcg9a2VBpIvxPXqEcVjkhMx2+zN7Qzng2zzlpvNyKLL5Me5cdyx/zrW
 sNgyVsjTk/b247Yk5ecFfaK3uof4qLnIUTysXrMJyNsm7Lj0CBzCisU7MYQVSKT+As6A
 e1k+HYp5Mc3XVm+1bHJHMQFt3yfDSA4AUcHtHS6A7vy4LdjxIsdXxjQlP+e2QTcsoonl
 fITQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYHZFAplm7qQ4MsWdD0DuxVmq9xDylf2EX8JOm75x733K89V+gvNPBuCT/q9UtMUIcD1mG07HSilVJ@nongnu.org
X-Gm-Message-State: AOJu0Ywq0YLG55o5+emm412MpAPTFg2hTG/0NKLF2VL5mprtRFORlQWM
 EOgd2yqsV/O3jti4v6TpucNyNpDHrVddamLCkIR/cFIBydsxHfYU
X-Google-Smtp-Source: AGHT+IFDN4BV4HgnYi6UqV59QbJ2WxKX6q2HlzRMGG3DoiznPA3cKsTJahVSL1Fz+SM/hYyXGtFoVw==
X-Received: by 2002:a17:903:182:b0:212:1f:e66b with SMTP id
 d9443c01a7336-212001feb63mr121492725ad.51.1731992447594; 
 Mon, 18 Nov 2024 21:00:47 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21223e5e1d2sm26748395ad.163.2024.11.18.21.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 21:00:47 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 15:00:40 +1000
Message-Id: <D5PW2UNAEQY8.3J5OIED7DU3AQ@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <clg@kaod.org>, <fbarrat@linux.ibm.com>,
 <milesg@linux.ibm.com>, <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>, <thuth@redhat.com>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: Re: [PATCH 12/14] pnv/xive: Support ESB Escalation
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-13-kowal@linux.ibm.com>
In-Reply-To: <20241015211329.21113-13-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Wed Oct 16, 2024 at 7:13 AM AEST, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>
> END notification processing has an escalation path.  The escalation is
> not always an END escalation but can be an ESB escalation.
>
> Also added a check for 'resume' processing which log a message stating it
> needs to be implemented.  This is not needed at the time but is part of
> the END notification processing.

This patch is orthogonal to group support, right?
>
> This change was taken from a patch provided by Michael Kowal
>
> Suggested-by: Michael Kowal <kowal@us.ibm.com>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  include/hw/ppc/xive2.h      |  1 +
>  include/hw/ppc/xive2_regs.h | 13 +++++---
>  hw/intc/xive2.c             | 61 +++++++++++++++++++++++++++++--------
>  3 files changed, 58 insertions(+), 17 deletions(-)
>
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 37aca4d26a..b17cc21ca6 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -82,6 +82,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool cro=
wd,
>  uint32_t xive2_router_get_config(Xive2Router *xrtr);
> =20
>  void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checke=
d);
> +void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
> =20
>  /*
>   * XIVE2 Presenter (POWER10)
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 89236b9aaf..42cdc91452 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -40,15 +40,18 @@
> =20
>  typedef struct Xive2Eas {
>          uint64_t       w;
> -#define EAS2_VALID                 PPC_BIT(0)
> -#define EAS2_END_BLOCK             PPC_BITMASK(4, 7) /* Destination EQ b=
lock# */
> -#define EAS2_END_INDEX             PPC_BITMASK(8, 31) /* Destination EQ =
index */
> -#define EAS2_MASKED                PPC_BIT(32) /* Masked                =
 */
> -#define EAS2_END_DATA              PPC_BITMASK(33, 63) /* written to the=
 EQ */
> +#define EAS2_VALID         PPC_BIT(0)
> +#define EAS2_QOS           PPC_BIT(1, 2)       /* Quality of Service(uni=
mp) */
> +#define EAS2_RESUME        PPC_BIT(3)          /* END Resume(unimp) */
> +#define EAS2_END_BLOCK     PPC_BITMASK(4, 7)   /* Destination EQ block# =
*/
> +#define EAS2_END_INDEX     PPC_BITMASK(8, 31)  /* Destination EQ index *=
/
> +#define EAS2_MASKED        PPC_BIT(32)         /* Masked */
> +#define EAS2_END_DATA      PPC_BITMASK(33, 63) /* written to the EQ */
>  } Xive2Eas;
> =20
>  #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
>  #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
> +#define xive2_eas_is_resume(eas)  (be64_to_cpu((eas)->w) & EAS2_RESUME)
> =20
>  void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf=
);
> =20
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 41d689eaab..f812ba9624 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1511,18 +1511,39 @@ do_escalation:
>          }
>      }
> =20
> -    /*
> -     * The END trigger becomes an Escalation trigger
> -     */
> -    xive2_router_end_notify(xrtr,
> -                           xive_get_field32(END2_W4_END_BLOCK,     end.w=
4),
> -                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w=
4),
> -                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w=
5));
> +    if (xive2_end_is_escalate_end(&end)) {
> +        /*
> +         * Perform END Adaptive escalation processing
> +         * The END trigger becomes an Escalation trigger
> +         */
> +        xive2_router_end_notify(xrtr,
> +                               xive_get_field32(END2_W4_END_BLOCK,     e=
nd.w4),
> +                               xive_get_field32(END2_W4_ESC_END_INDEX, e=
nd.w4),
> +                               xive_get_field32(END2_W5_ESC_END_DATA,  e=
nd.w5));
> +    } /* end END adaptive escalation */
> +
> +    else {
> +        uint32_t lisn;              /* Logical Interrupt Source Number *=
/
> +
> +        /*
> +         *  Perform ESB escalation processing
> +         *      E[N] =3D=3D 1 --> N
> +         *      Req[Block] <- E[ESB_Block]
> +         *      Req[Index] <- E[ESB_Index]
> +         *      Req[Offset] <- 0x000
> +         *      Execute <ESB Store> Req command
> +         */
> +        lisn =3D XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4=
),
> +                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4))=
;
> +
> +        xive2_notify(xrtr, lisn, true /* pq_checked */);
> +    }
> +
> +    return;

Don't need returns at the end of void functions.

>  }
> =20
> -void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checke=
d)
> +void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)

Can it be static?

Thanks,
Nick

>  {
> -    Xive2Router *xrtr =3D XIVE2_ROUTER(xn);
>      uint8_t eas_blk =3D XIVE_EAS_BLOCK(lisn);
>      uint32_t eas_idx =3D XIVE_EAS_INDEX(lisn);
>      Xive2Eas eas;
> @@ -1565,13 +1586,29 @@ void xive2_router_notify(XiveNotifier *xn, uint32=
_t lisn, bool pq_checked)
>          return;
>      }
> =20
> +    /* TODO: add support for EAS resume if ever needed */
> +    if (xive2_eas_is_resume(&eas)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "XIVE: EAS resume processing unimplemented - LISN =
%x\n",
> +                      lisn);
> +        return;
> +    }
> +
>      /*
>       * The event trigger becomes an END trigger
>       */
>      xive2_router_end_notify(xrtr,
> -                             xive_get_field64(EAS2_END_BLOCK, eas.w),
> -                             xive_get_field64(EAS2_END_INDEX, eas.w),
> -                             xive_get_field64(EAS2_END_DATA,  eas.w));
> +                            xive_get_field64(EAS2_END_BLOCK, eas.w),
> +                            xive_get_field64(EAS2_END_INDEX, eas.w),
> +                            xive_get_field64(EAS2_END_DATA,  eas.w));
> +}
> +
> +void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checke=
d)
> +{
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(xn);
> +
> +    xive2_notify(xrtr, lisn, pq_checked);
> +    return;
>  }
> =20
>  static Property xive2_router_properties[] =3D {


