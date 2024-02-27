Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07171C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retBy-0007e2-VA; Tue, 27 Feb 2024 03:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1retBx-0007ay-IE; Tue, 27 Feb 2024 03:52:01 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1retBw-0003D7-3x; Tue, 27 Feb 2024 03:52:01 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c1adc90830so245758b6e.0; 
 Tue, 27 Feb 2024 00:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709023918; x=1709628718; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGRsftJK0dyXYop60Oiy6rGFnlmoAzqDrZJLQVERQIk=;
 b=OYrjyg4xrnZo4oWnVJDRx+t9Oemyh8QyDqQqcIb+DRpKy9RczfV+vnUbq8zenyEwiI
 /IYsQCgogXAbI1LpAXsHsBNCkWTwdHuMEK+H7ylD6DCTdRAxMZcud1ZiyTGzmVB5TbOX
 nNW8mz+P/07HIjN5Hu0IPhegfZUFUz5qtNcPO8wg0urkHcPeJFZDX6bhPXGahGjvolMH
 nL4lFe6HQLHIL64awxQgTa2pmYvIGwlgWFmvRCI/cBBJK30xuPXJZhDCkrOJEPsWrZWs
 QRiuCLnC0qT5p/JIvdDbkS16Ys/phMiPlsh08sevRaZ5+JU4mZUCr9507RfkL+kaY8Ob
 +KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023918; x=1709628718;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yGRsftJK0dyXYop60Oiy6rGFnlmoAzqDrZJLQVERQIk=;
 b=mtZC200rJRlOBNSbp3vNE3T8wXmPk0A4NpdMPH5wFczpk6dFGka+GzC6y/CLwumJA+
 6hDUSN6rrYYXZYABGfdS30rFfRnEBvm77xb+boP7TCF798fTt7w3hrjT0xwc/PhsenHZ
 C8H52JQauMZTOFM3rUNapnf9M6/0l1YGORTDgs6cRnj+9j6FfmvrE2Ujt2t2IRyo02z6
 s650+FaRG+X5IDG1HYShaxvk96iOLGdrF4mVLigfQGE43NZQ0NkCh6YIkfl3n4qYBwU1
 81aYJhB/L7vHnGAuU8rbPt6YiJGzlAKFJCapeTye7S+VEie5S5QWECuS27votxYhAg4j
 ++LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Z+h3ksTk9Avv4GvF+VDvJVex23Co9peQkOSP0o1h7citQXVOj3mY9sBGlPCl4bH4hGG+IRwjgHLYNE6SVwhShrMJSm9yVSLfdyiGMqJTU1+jrMHSsdzXrz4=
X-Gm-Message-State: AOJu0Yy6JNlnAhKFfE6eDzUlbAqjmVQLtY2X+Q+105v8moYnmzeoSXSQ
 VsmxggY9odeC2ZV4kYGQf9dBZE5UTlSAM9tmMHLCrVv39W5Xz6PO
X-Google-Smtp-Source: AGHT+IGihhXSamQk4+xOteUT6qPuy4bW5Ht+6/Nwl8nM+yvxRkXSqZIt52arVuJMqPanawd3f0dGZw==
X-Received: by 2002:aca:2b0b:0:b0:3c1:7d97:c4ba with SMTP id
 i11-20020aca2b0b000000b003c17d97c4bamr1325487oik.48.1709023918153; 
 Tue, 27 Feb 2024 00:51:58 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 t1-20020a632241000000b005c662e103a1sm5217958pgm.41.2024.02.27.00.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 00:51:57 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 18:51:48 +1000
Message-Id: <CZFQEX5BIYZ0.13FK4Y38CPV48@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 01/15] spapr: nested: register nested-hv api hcalls
 only for cap-nested-hv
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-2-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-2-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x235.google.com
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

On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
> Since cap-nested-hv is an optional capability, it makes sense to register
> api specfic hcalls only when respective capability is enabled. This
> requires to introduce a new API to unregister hypercalls to maintain
> sanity across guest reboot since caps are re-applied across reboots and
> re-registeration of hypercalls would hit assert otherwise.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/hw/ppc/spapr.h        |  3 +++
>  include/hw/ppc/spapr_nested.h |  1 -
>  hw/ppc/spapr_caps.c           |  2 ++
>  hw/ppc/spapr_hcall.c          | 24 ++++++++++++++++++++++--
>  hw/ppc/spapr_nested.c         | 17 +++++++++++++++--
>  5 files changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e91791a1a9..b7ad2a0360 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -631,6 +631,7 @@ typedef target_ulong (*spapr_hcall_fn)(PowerPCCPU *cp=
u, SpaprMachineState *sm,
>                                         target_ulong *args);
> =20
>  void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
> +void spapr_unregister_hypercall(target_ulong opcode);
>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>                               target_ulong *args);
> =20
> @@ -1025,5 +1026,7 @@ void spapr_vof_client_dt_finalize(SpaprMachineState=
 *spapr, void *fdt);
> =20
>  /* H_WATCHDOG */
>  void spapr_watchdog_init(SpaprMachineState *spapr);
> +void spapr_register_nested_hv(void);
> +void spapr_unregister_nested_hv(void);
> =20
>  #endif /* HW_SPAPR_H */
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index d312a5d61d..09d95182b2 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -95,7 +95,6 @@ struct nested_ppc_state {
>      int64_t tb_offset;
>  };
> =20
> -void spapr_register_nested(void);
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp);
> =20
>  #endif /* HW_SPAPR_NESTED_H */
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index e889244e52..f0c2f4de78 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -487,6 +487,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState=
 *spapr,
>              error_append_hint(errp, "Try appending -machine cap-nested-h=
v=3Doff "
>                                      "or use threads=3D1 with -smp\n");
>          }
> +        spapr_unregister_nested_hv(); /* reset across reboots */
> +        spapr_register_nested_hv();

This looks a bit odd. And actually it also ends up registering them in
the SMT error case (which seems harmelss but a bit inconsistent).

I wonder whether you could make a spapr_nested_reset() function called
by spapr_machine_reset that would take care of
unregistering and reregistering nested hypercalls based on the caps that
were set.

Thanks,
Nick

