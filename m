Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69670C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgLV-0002fR-Vs; Fri, 31 Jul 2026 02:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgLT-0002dy-NK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:03:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgLR-0003gs-8S
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:03:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V5hKi53583252
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P1+IaPA8THfKbBjIuhq3DCVsUGXqlS4o7feR5cMuVJs=; b=gmN4EtlcG3o5/jQ1
 xh7ezmJwAIEZ/+mZb9r0cLwOdKBULAPqM17m+HVJ8xv3baakCqNl3hbHO3zn/4aO
 LbDVlDOS6yHys1oXPBUykkCS+gBRwuV89qMOjWWACd0z9SgRRbBD04KpAcGTiEld
 uKzeesQuk64J3WpDPEk4L13bRr3dedrvK00jq2RqiXius1bgGgDilgPCspu/pfqm
 0tKhrtSzv69ocuzC1P7ZpSUX1X6MukKpBWLsYWAmiW93Nz53ds3FGnY1x5hxCUsT
 g36NmUMqh3HQ8dFpu3eCB2hovi8eC+XfA552DoEbdS+N7+nPrhw7T6fB3va0sxeV
 WwQ+kg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frntcg2as-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:03:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ef8249f73fso12017276d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785477788; x=1786082588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P1+IaPA8THfKbBjIuhq3DCVsUGXqlS4o7feR5cMuVJs=;
 b=NH1O4BixUgXDp+jmzkExiQGc6S+HJkSUgHbS6kTt6ZnsXgY2LXDoa/nOMDRWSlzKUt
 N6TPkQI6P2UuWWZ7jjoTEfQ339md1tazOSERmqt+8cHaD5TNBAPrX9IFH7ePU2H1f8NQ
 lxv9omxHYrBFVpXnoeBTJmyod5zKFXx9C0JQEOARDcoz5D3kUqfVjkTC1Mev4Po5LOb2
 pTJy5/jxPeSSmiev3sHGn+MI5bAV6N8jaOsBLg1iQH3oGR0X8p4cTAgN6kuIa/liVOe6
 MHF9TwW2N74EPDzSKz2EEpsYtA88bFWJ2Gcm7JzS2jo66NBatnVDDbCqXXorvI+3nCkj
 ffSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785477788; x=1786082588;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P1+IaPA8THfKbBjIuhq3DCVsUGXqlS4o7feR5cMuVJs=;
 b=soLTh8hFAEsDG0YTVSPnZQDX+loOHcMNTxVg+DPaJD+q8CNwBzk06Tn3XMVj9rmehA
 YvLrXXbAxPySS7B5gPOlZtcLfaDcpKB4SNAvXv5NzgHlCRG6yC5ujHWCcRCjLBtpLKiu
 EcKAPCy4LeLS350kcVhDMLrm7AlSPDzU8L0mGEOArndU95sSFG3Q5r9m+11nckq4ViEZ
 1d+fE3J297MBN4qO+33CASUNMUOlcWsEszqWgB4HV3Y3kyADbcAbo3hryjEKuKdmxxQ9
 oHJN7GXiZMQwuQCHCbqgo9ncxjAsNamqMR3FKP7fYY0H0mXIuPu/xX/5YhvCIQ8vfzir
 FhPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSZYVu5T2spGxA7eD+UfIqCY6oXvM9tJ8adtS6ccbhfpOdotLGZ8jGUGcK9NAwKmRfE4LNwTNc3/eE@nongnu.org
X-Gm-Message-State: AOJu0YyT9TLYFh2WUXij/OmVMYjGSZ3ynOueg6n1PC0cWQwgNAjlBLtr
 tBC0F4VGrbmy22He69LXMZx7tX1tl2xpZP8fc6xU4XaERSRSorLxDqCCsZnGLfvSFGu14nOOXrS
 w5WQ5lXt6g8cpvAtaFw4VieOjxnyXhJ7XRtMvklbs3hfwn3yzhOiQq86w9g==
X-Gm-Gg: AR+sD10UwJIPy/rbngRVjHWMEmTD8SNZbWgvBnWrCyc3mCKOhvWJxkgh1OLPmAyeWia
 pVj0ZxRHY4NUP3auV2zcJaOUMClf0wlQYW9lKVe9DQgOfWUQlWlhRrU6X1qGDU5fgmsp5Y6ErT6
 oPYZaJ21cJPb54q0ZA5+10Q4yRjVF4FhT6bVPjQfFcJImJk0YRYMsihYug9DNRpMBLExdaOuAqC
 zG2s2B/og6ccQz/fsOtvPbiXpLhlUYYjGQ5yOqG2TTrv6b2KyDfTDpA/HUHo0ApL/+RWCA2dQEA
 8KFX3LgHEg6Uaq2S/4ZzpbvJqCvWOjSli/Tm0YfTEAaoGqxoUP4tO1XaFqIeZHIHttQ3Mo7KesH
 xQEFcxBANwlD0g9HfVU10eyCGqpSATwUWxAqZ9zcO4kvy0bQv1Eo=
X-Received: by 2002:a05:622a:647:b0:51c:849b:86b with SMTP id
 d75a77b69052e-52b4b0e24bdmr7977771cf.43.1785477787907; 
 Thu, 30 Jul 2026 23:03:07 -0700 (PDT)
X-Received: by 2002:a05:622a:647:b0:51c:849b:86b with SMTP id
 d75a77b69052e-52b4b0e24bdmr7977441cf.43.1785477787513; 
 Thu, 30 Jul 2026 23:03:07 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c5c6e12sm195780a12.13.2026.07.30.23.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:03:06 -0700 (PDT)
Message-ID: <976c63a9-4ffd-44e6-b549-1bcb16f7ebb2@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 08:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/vmxnet3: Do not abort if guest provides bad
 interrupt numbers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org
References: <20260730143943.1117129-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730143943.1117129-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Pne-bJcXZh0m8G0H-z_0O3hVGH0kemv1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOSBTYWx0ZWRfXxe09M9ml/5Ul
 rmcZvFD1OgGe2j66QtJt61QliZ8w0K8oOlTcHl9/eWgpdLpzE3yTIx8Lyv/7v06rbyBCk3vNZSy
 hQfSJkRaK0EQoYKD0eVp7SvcHkm+zlY=
X-Proofpoint-ORIG-GUID: Pne-bJcXZh0m8G0H-z_0O3hVGH0kemv1
X-Authority-Analysis: v=2.4 cv=BcnoFLt2 c=1 sm=1 tr=0 ts=6a6c3ab8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vdYDXrpWxUw4qL7IyggA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOSBTYWx0ZWRfX1OCfVZ267XBO
 WLbh3rdTmgvzQK559UhQmbTO4RSU3Nh/ozbYtJMoAD3yjQNLpJPXasQRCMxEWL0P5QC8e+5YkfT
 JDVXtWlOb+AFn6lx/g/Mq7Rmo3N7eZSXUnj3eY8XBsahfqiBGk0yVANDvkq3D4cG/iWfcBiTZo0
 orJuwKI+VttzwJGA1V9ioxq9GSz2HtUiMgjJEh+AAtVAj0Bkea7vTov7CbzYJ2aPfi4dNFFlC4n
 DQ5vlqiJ8NkgtepXV/ysynUQpT5ri++0X3ZKLS5a7HYBfYaDj1ySZatRnwArKg+SdeocVT05njI
 Pbtk6+rfkEetL4MdCYIeHHcRibrn6IomDoPPTO2CgfdZR2MgkJYbis7K4e1U05Rk5OphdGPHf71
 E8vClZORAUNGjHOHn2T1HHVwRScrPE1XODUuhqBimyjZQlmhPbuc9RsIjzQN1JLSeGsxoZEXuOM
 m59ieMdDpE0JER+ZRwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Thomas,

On 30/7/26 16:39, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> vmxnet3_validate_interrupts() currently aborts via hw_error() if
> the guest provided bad interrupt numbers. This should not happen,
> QEMU should rather refuse to activate the device in this case instead.
> Thus propagate the error to the callers to handle it more gracefully
> there.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/539
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/net/vmxnet3.c | 35 +++++++++++++++++++++++++++--------
>   1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 8569484b2f2..1c5d1d740cc 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -1336,32 +1336,46 @@ static bool vmxnet3_verify_intx(VMXNET3State *s, int intx)
>           || intx == pci_get_byte(s->parent_obj.config + PCI_INTERRUPT_PIN) - 1;
>   }
>   
> -static void vmxnet3_validate_interrupt_idx(bool is_msix, int idx)
> +static bool vmxnet3_validate_irq_idx(const char *type, bool is_msix, int idx)
>   {
>       int max_ints = is_msix ? VMXNET3_MAX_INTRS : VMXNET3_MAX_NMSIX_INTRS;
> +
>       if (idx >= max_ints) {
> -        hw_error("Bad interrupt index: %d\n", idx);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "vmxnet3: Bad %s queue interrupt index: %d\n",
> +                      type, idx);
> +        return false;
>       }
> +
> +    return true;
>   }
>   
> -static void vmxnet3_validate_interrupts(VMXNET3State *s)
> +static bool vmxnet3_validate_interrupts(VMXNET3State *s)
>   {
>       int i;
>   
>       VMW_CFPRN("Verifying event interrupt index (%d)", s->event_int_idx);
> -    vmxnet3_validate_interrupt_idx(s->msix_used, s->event_int_idx);
> +    if (!vmxnet3_validate_irq_idx("event", s->msix_used, s->event_int_idx)) {
> +        return false;
> +    }
>   
>       for (i = 0; i < s->txq_num; i++) {
>           int idx = s->txq_descr[i].intr_idx;
>           VMW_CFPRN("Verifying TX queue %d interrupt index (%d)", i, idx);
> -        vmxnet3_validate_interrupt_idx(s->msix_used, idx);
> +        if (!vmxnet3_validate_irq_idx("TX", s->msix_used, idx)) {
> +            return false;
> +        }
>       }
>   
>       for (i = 0; i < s->rxq_num; i++) {
>           int idx = s->rxq_descr[i].intr_idx;
>           VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
> -        vmxnet3_validate_interrupt_idx(s->msix_used, idx);
> +        if (!vmxnet3_validate_irq_idx("RX", s->msix_used, idx)) {
> +            return false;
> +        }
>       }
> +
> +    return true;
>   }
>   
>   static bool vmxnet3_validate_queues(VMXNET3State *s)
> @@ -1554,7 +1568,10 @@ static void vmxnet3_activate_device(VMXNET3State *s)
>                  sizeof(s->rxq_descr[i].rxq_stats));
>       }
>   
> -    vmxnet3_validate_interrupts(s);
> +    if (!vmxnet3_validate_interrupts(s)) {
> +        vmxnet3_reset(s);
> +        return;

We definitively want to return here to not set s->device_active,
but calling vmxnet3_reset() in the middle of a command handler is
surprising. Maybe call it in the caller?

-- >8 --
@@ -1554,7 +1554,9 @@ static void vmxnet3_activate_device(VMXNET3State *s)
                 sizeof(s->rxq_descr[i].rxq_stats));
      }

-    vmxnet3_validate_interrupts(s);
+    if (!vmxnet3_validate_interrupts(s)) {
+        return false;
+    }

      /* Make sure everything is in place before device activation */
      smp_wmb();
@@ -1584,7 +1586,9 @@ static void vmxnet3_handle_command(VMXNET3State 
*s, uint64_t cmd)

      case VMXNET3_CMD_ACTIVATE_DEV:
          VMW_CBPRN("Set: Activating vmxnet3 device");
-        vmxnet3_activate_device(s);
+        if (!vmxnet3_activate_device(s)) {
+            vmxnet3_reset(s);
+        }
          break;

      case VMXNET3_CMD_UPDATE_RX_MODE:
---

Regardless this patch fixes what it aims to, and -- while I don't
have much knowledge of this device -- it looks reasonable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    }
>   
>       /* Make sure everything is in place before device activation */
>       smp_wmb();
> @@ -2392,7 +2409,9 @@ static int vmxnet3_post_load(void *opaque, int version_id)
>       if (!vmxnet3_validate_queues(s)) {
>           return -1;
>       }
> -    vmxnet3_validate_interrupts(s);
> +    if (!vmxnet3_validate_interrupts(s)) {
> +        return -1;
> +    }
>   
>       return 0;
>   }


