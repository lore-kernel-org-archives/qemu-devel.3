Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC25C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuydW-0001Dh-Dv; Wed, 19 Mar 2025 14:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tuydT-0001D9-GW
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:59:27 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tuydP-0003G4-VX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:59:27 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54991d85f99so1209607e87.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1742410761; x=1743015561;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHCPlvZKPdE/9xejrtzVoDSTQ6BH+cVINV9nEm2c3+E=;
 b=u2++i+/isl0vfSnWnws4bbazP6ZfmsMp12UmfOwT2b4fzcs3F/JYJL8rMz8ULa2/8U
 /AkjpzA7nIWbSo97mp9ZCoEF6+sNK3m3QoF87NGA5kScQxU71j0VvaTvYeB5sNIWVplm
 vhcLsHBnbSWDJXyCsiPpIe38dIIjcX1U1087hTl0XJFpni4zTm2RQsCK7GwRhT6fRPMr
 AMijA6peF5X841NMWQR971HtMw3oj1s5kc3b3gElI0apPOYwfksYG+iikl6dLrfz55cp
 SImpYm363aGVyS+B25umZdHbtqrTxglfXpZa+6PTXJmW/Mi9OYYe13OOKAzg5ZVZ9N/3
 m2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742410761; x=1743015561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHCPlvZKPdE/9xejrtzVoDSTQ6BH+cVINV9nEm2c3+E=;
 b=oImiwEQyzhFRC4AXpDniWCjheWapCdlmpBleB50sZphowbtmrvzOiQ8ONS37Mdny7Z
 7x+/CVdQNfwpBOeYCnQImZuX54AXEOsyxY+I1utVQjIfsQQbZUu7Cz4L8fVe5Ki2nCgW
 CfX3/hZRQL8yPlc1rX0m/7/QbukVptBI3YZvX71iO4ef/uUgmOL+1CZ3Ay78hoLQuoBP
 U+VFi7PjTf2utV10rHnm2Mc8oVCzcpHkMxGJjKCe2JcNObp8mjJA7rVBWMNDE9J5wQ+F
 mtadz2F657FGV4qMLCkq+xLIZDGlr0umDLdd3XLMaRbUy9sknB/55QPFSE7pJk9bOffw
 qoLw==
X-Gm-Message-State: AOJu0YwGcoE1mDL9VM9dLZnVhskEAHrU+/vzJAQ+ARXWZPzN618FzxE9
 RoC6o2dSztXlqCWa6w39mw3q2DMnTr/MX8MAMMkYTnppUZY6b6Gwk6iG96KJsQuMxhtG+Kg9Ob5
 QPYeo0klcf3UCOwppDwT8EFQFC2/O6Kn5YnB9yw==
X-Gm-Gg: ASbGnctgM6l4za5jmNpetjYHSeW3yqXaItLtnYvZ0S5Ua2X9tNkqxoj8bWhTAIcYuX3
 PkNhro86LyW2IfKtR0FJKNUETp7ZvGblVKJa1HljivRUMaHP7dIWFJ5T/jlulpSivd25/SktipB
 L11s2pNw295SbfvK4lkeJ2EPLHaUu6feohmXM/PQtwKTtFRSU01wAwUA0H
X-Google-Smtp-Source: AGHT+IGN9aDrOWiM/NdaFjgPweKQmWdwTw4hvVdt7WvTjMxgiBjydi3nowf3J3E6RHMe6LrB6oFRLp+1aV+nWbhOx/Y=
X-Received: by 2002:a05:6512:3e17:b0:549:4cb0:4d74 with SMTP id
 2adb3069b0e04-54acfa9429amr229517e87.8.1742410760512; Wed, 19 Mar 2025
 11:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250319152126.3472290-1-armbru@redhat.com>
 <20250319152126.3472290-4-armbru@redhat.com>
In-Reply-To: <20250319152126.3472290-4-armbru@redhat.com>
From: Corey Minyard <corey@minyard.net>
Date: Wed, 19 Mar 2025 13:59:09 -0500
X-Gm-Features: AQ5f1Jr83fTdnSUkP438BPf6qoqG4htEoGOoaMp32-8e5JqzXxBrC0l49SHWO3g
Message-ID: <CAB9gMfrxe7NWk_1GkudEeWby-ZHaH1xTWD5n7WfK7iz4qKsL6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] cleanup: Drop pointless label at end of function
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=corey@minyard.net; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Is this official coding style?  I'm not a big fan of having return
statements in the middle of functions, I generally only put them at
the beginning or the end.

-corey

On Wed, Mar 19, 2025 at 10:26=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ipmi/ipmi_bmc_extern.c | 4 +---
>  hw/ipmi/ipmi_bmc_sim.c    | 7 ++-----
>  hw/ipmi/ipmi_bt.c         | 7 +++----
>  hw/ipmi/ipmi_kcs.c        | 3 +--
>  4 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index 73b249fb60..ab9b66274d 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -213,7 +213,7 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b=
,
>          rsp[2] =3D err;
>          ibe->waiting_rsp =3D false;
>          k->handle_rsp(s, msg_id, rsp, 3);
> -        goto out;
> +        return;
>      }
>
>      addchar(ibe, msg_id);
> @@ -228,8 +228,6 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b=
,
>
>      /* Start the transmit */
>      continue_send(ibe);
> -
> - out:
>  }
>
>  static void handle_hw_op(IPMIBmcExtern *ibe, unsigned char hw_op)
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index faec6fefb3..f4336946ce 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -463,13 +463,12 @@ void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, b=
ool log)
>      }
>
>      if (ibs->msg_flags & IPMI_BMC_MSG_FLAG_EVT_BUF_FULL) {
> -        goto out;
> +        return;
>      }
>
>      memcpy(ibs->evtbuf, evt, 16);
>      ibs->msg_flags |=3D IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
>      k->set_atn(s, 1, attn_irq_enabled(ibs));
> - out:
>  }
>  static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t de=
assert,
>                        uint8_t evd1, uint8_t evd2, uint8_t evd3)
> @@ -979,7 +978,7 @@ static void get_msg(IPMIBmcSim *ibs,
>
>      if (QTAILQ_EMPTY(&ibs->rcvbufs)) {
>          rsp_buffer_set_error(rsp, 0x80); /* Queue empty */
> -        goto out;
> +        return;
>      }
>      rsp_buffer_push(rsp, 0); /* Channel 0 */
>      msg =3D QTAILQ_FIRST(&ibs->rcvbufs);
> @@ -994,8 +993,6 @@ static void get_msg(IPMIBmcSim *ibs,
>          ibs->msg_flags &=3D ~IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE;
>          k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
>      }
> -
> -out:
>  }
>
>  static unsigned char
> diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
> index 3ef1f435e7..f769cfa243 100644
> --- a/hw/ipmi/ipmi_bt.c
> +++ b/hw/ipmi/ipmi_bt.c
> @@ -98,14 +98,14 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
>      IPMIBT *ib =3D iic->get_backend_data(ii);
>
>      if (ib->inlen < 4) {
> -        goto out;
> +        return;
>      }
>      /* Note that overruns are handled by handle_command */
>      if (ib->inmsg[0] !=3D (ib->inlen - 1)) {
>          /* Length mismatch, just ignore. */
>          IPMI_BT_SET_BBUSY(ib->control_reg, 1);
>          ib->inlen =3D 0;
> -        goto out;
> +        return;
>      }
>      if ((ib->inmsg[1] =3D=3D (IPMI_NETFN_APP << 2)) &&
>                          (ib->inmsg[3] =3D=3D IPMI_CMD_GET_BT_INTF_CAP)) =
{
> @@ -136,7 +136,7 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
>              IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
>              ipmi_bt_raise_irq(ib);
>          }
> -        goto out;
> +        return;
>      }
>      ib->waiting_seq =3D ib->inmsg[2];
>      ib->inmsg[2] =3D ib->inmsg[1];
> @@ -145,7 +145,6 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
>          bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
>                             sizeof(ib->inmsg), ib->waiting_rsp);
>      }
> - out:
>  }
>
>  static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
> diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
> index f4f1523d6b..5bfc34676f 100644
> --- a/hw/ipmi/ipmi_kcs.c
> +++ b/hw/ipmi/ipmi_kcs.c
> @@ -168,7 +168,7 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
>              ik->outpos =3D 0;
>              bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik-=
>inmsg),
>                                 ik->waiting_rsp);
> -            goto out_noibf;
> +            return;
>          } else if (ik->cmd_reg =3D=3D IPMI_KCS_WRITE_END_CMD) {
>              ik->cmd_reg =3D -1;
>              ik->write_end =3D 1;
> @@ -197,7 +197,6 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
>      ik->cmd_reg =3D -1;
>      ik->data_in_reg =3D -1;
>      IPMI_KCS_SET_IBF(ik->status_reg, 0);
> - out_noibf:
>  }
>
>  static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
> --
> 2.48.1
>
>

