Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805ACF99355
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFq3r-00024j-UN; Thu, 23 Apr 2026 05:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wFq3o-00024L-Bo
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:09:24 -0400
Received: from 11.mo534.mail-out.ovh.net ([46.105.33.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wFq3i-0007O8-FY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:09:23 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4g1Vdj6z9Kz6C7P;
 Thu, 23 Apr 2026 09:09:13 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 23 Apr 2026 09:09:13 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.159])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g1Vdj5XsCz5vLx; Thu, 23 Apr 2026 09:09:13 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 98E6912E3ABD;
 Thu, 23 Apr 2026 09:09:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00323dac758-f4eb-4e8c-ad42-68824b72ac4a,
 C846149266E0C9F4D826987B86006927C6E58490) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <99bde91f-3fd3-4ee4-b6a0-fb87f475beb7@kaod.org>
Date: Thu, 23 Apr 2026 11:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...)
 with qemu_log_mask(LOG_GUEST_ERROR)
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "farosas@suse.de" <farosas@suse.de>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
 <20260423051804.362095-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260423051804.362095-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16265031531562839085
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF1BgfI+RMK4QQMmuVi4smpDE0Oq6a6EHDHWJYBwyVTS18sGWpDs+/4vZN1qwZX4X/pVdJX+m144wWEdCmbag8Wnl2x/cZif6VMkUPCxXUVAR0zr8YdcN4jFyw01M8SK7oV14H6ZUke/RzRgWS/RKgGXsauu39oNoXe0FB4Ro8U3naaA2v6GndaV7pYJFKn04S8GN3+pWzJbGlMvdvfw+AW5uq364vM0goQO/ViH5tMlZrivTvf4H928OplsbgDtUtW7hRNxmjQ/1K83XD0tBFY3b+3DejR2vmYL7gRBsEmv/nVA7IaewwpahKeW0ksc0vu3VnYOwrFnE8dcWIEXSPmRnG9wQvHiJ8p0E87xtINJx1hluDujKezc467Wz7e3efEK8uULsUqIGaL+eeilfPNwbv+atho/MQgHgnFCyQqDawvKpSzi3g2C0Ed6IC5bLSvRBuHkqKwYyKg2HCl4bi57Onbhzx45CMOxlPTsi7vyTX54RJ4pSWmiUiyN4hjeEiwuM3ghSoEEECfjcCKg7cPAruLb+uBOQXgTUHP2kazIm8DiwC9XtdjCitIMMiY70564l3nGrnRSn1IcvuFbS+XZKqFa7f/LxK8EgfTk4BhIcaVnsrJb7deuh22mor9Gxcu6JRTgTZTSxo1lHfdAO9r1MBtUWSXoN0lyAlMsnT9WQ
DKIM-Signature: a=rsa-sha256; bh=TkTUP6p2Z6fnkDKBXsguBiUQ34+T7ASm+4iEVFva1Q8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776935354; v=1;
 b=SdXxV63nSZjltHKmcZXqkyF2t4PDNMVxRA35kooylwzvJN/zkyChyqkgSCbIX6GaRzOeLayh
 4KqORc73FOXlDA9o3828z4HY1+qYH4yuobOmgr0+vuXMnzRxB0RR3OmKdQ1hRPfAHJAmKJiNyZj
 Tmro9ZHX4hwCfVYEzod1gFLLZlFHq/NZLopxTxMD0AkvLrsJW4BMfwVKOLw/vcjkZW/W49Pe9op
 DWpVFK+asQNUkssMXDek+Me1ctIBe0NufjRkjaq4776YyAbA4RXr6cGQpx4Bi3iRWeDW75FymZb
 tOXUQaUnQVyDgcvumtFFOQS0rr5kHMUSCGG+dhPHcgyig==
Received-SPF: pass client-ip=46.105.33.174; envelope-from=clg@kaod.org;
 helo=11.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/26 07:18, Jamin Lin wrote:
> Replace direct fprintf(stderr, ...) calls with qemu_log_mask()
> using LOG_GUEST_ERROR in the EHCI controller implementation.
> 
> Direct writes to stderr are discouraged in QEMU as they bypass
> the logging framework and cannot be filtered or controlled at
> runtime. Using qemu_log_mask() ensures that guest-visible errors
> are properly categorized and can be managed via QEMU logging
> options.
> 
> All affected messages correspond to guest-triggerable error
> conditions, so LOG_GUEST_ERROR is used consistently.
> 
> This change improves integration with QEMU's logging infrastructure
> and aligns with upstream coding guidelines.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.c | 46 +++++++++++++++++++++++++---------------------
>   1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 7e0b767eb9..8acaedeaa9 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -36,6 +36,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "system/runstate.h"
> +#include "qemu/log.h"
>   
>   #define FRAME_TIMER_FREQ 1000
>   #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
> @@ -425,7 +426,7 @@ static int ehci_get_pid(EHCIqtd *qtd)
>       case 2:
>           return USB_TOKEN_SETUP;
>       default:
> -        fprintf(stderr, "bad token\n");
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad token\n");
>           return 0;
>       }
>   }
> @@ -532,7 +533,7 @@ static void ehci_free_packet(EHCIPacket *p)
>       }
>       if (p->async == EHCI_ASYNC_FINISHED &&
>               p->packet.status == USB_RET_SUCCESS) {
> -        fprintf(stderr,
> +        qemu_log_mask(LOG_GUEST_ERROR,
>                   "EHCI: Dropping completed packet from halted %s ep %02X\n",
>                   (p->pid == USB_TOKEN_IN) ? "in" : "out",
>                   get_field(p->queue->qh.epchar, QH_EPCHAR_EP));
> @@ -1042,8 +1043,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>   
>           /* not supporting dynamic frame list size at the moment */
>           if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {
> -            fprintf(stderr, "attempt to set frame list size -- value %d\n",
> -                    (int)val & USBCMD_FLS);
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "attempt to set frame list size -- value %" PRId64
> +                          "\n", val & USBCMD_FLS);
>               val &= ~USBCMD_FLS;
>           }
>   
> @@ -1101,7 +1103,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>   
>       case PERIODICLISTBASE:
>           if (ehci_periodic_enabled(s)) {
> -            fprintf(stderr,
> +            qemu_log_mask(LOG_GUEST_ERROR,
>                 "ehci: PERIODIC list base register set while periodic schedule\n"
>                 "      is enabled and HC is enabled\n");
>           }
> @@ -1109,7 +1111,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>   
>       case ASYNCLISTADDR:
>           if (ehci_async_enabled(s)) {
> -            fprintf(stderr,
> +            qemu_log_mask(LOG_GUEST_ERROR,
>                 "ehci: ASYNC list address register set while async schedule\n"
>                 "      is enabled and HC is enabled\n");
>           }
> @@ -1200,7 +1202,7 @@ static int ehci_init_transfer(EHCIPacket *p)
>   
>       while (bytes > 0) {
>           if (cpage > 4) {
> -            fprintf(stderr, "cpage out of range (%u)\n", cpage);
> +            qemu_log_mask(LOG_GUEST_ERROR, "cpage out of range (%u)\n", cpage);
>               qemu_sglist_destroy(&p->sgl);
>               return -1;
>           }
> @@ -1306,7 +1308,8 @@ static void ehci_execute_complete(EHCIQueue *q)
>           break;
>       default:
>           /* should not be triggerable */
> -        fprintf(stderr, "USB invalid response %d\n", p->packet.status);
> +        qemu_log_mask(LOG_GUEST_ERROR, "USB invalid response %d\n",
> +                      p->packet.status);
>           g_assert_not_reached();
>       }
>   
> @@ -1354,7 +1357,7 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>              p->async == EHCI_ASYNC_INITIALIZED);
>   
>       if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {
> -        fprintf(stderr, "Attempting to execute inactive qtd\n");
> +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to execute inactive qtd\n");
>           return -1;
>       }
>   
> @@ -1395,7 +1398,8 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>               p->packet.actual_length);
>   
>       if (p->packet.actual_length > BUFF_SIZE) {
> -        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ret from usb_handle_packet > BUFF_SIZE\n");
>           return -1;
>       }
>   
> @@ -1479,8 +1483,9 @@ static int ehci_process_itd(EHCIState *ehci,
>               case USB_RET_SUCCESS:
>                   break;
>               default:
> -                fprintf(stderr, "Unexpected iso usb result: %d\n",
> -                        ehci->ipacket.status);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Unexpected iso usb result: %d\n",
> +                              ehci->ipacket.status);
>                   /* Fall through */
>               case USB_RET_IOERROR:
>               case USB_RET_NODEV:
> @@ -1584,7 +1589,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   
>       /* section 4.8, only QH in async schedule */
>       if (async && (NLPTR_TYPE_GET(entry) != NLPTR_TYPE_QH)) {
> -        fprintf(stderr, "non queue head request in async schedule\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "non queue head request in async schedule\n");
>           return -1;
>       }
>   
> @@ -1606,8 +1612,10 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   
>       default:
>           /* TODO: handle FSTN type */
> -        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "
> -                "which is not supported yet\n", entry, NLPTR_TYPE_GET(entry));
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FETCHENTRY: entry at 0x%x is of type %u "
> +                      "which is not supported yet\n",
> +                      entry, NLPTR_TYPE_GET(entry));
>           return -1;
>       }
>   
> @@ -2118,13 +2126,13 @@ static void ehci_advance_state(EHCIState *ehci, int async)
>               break;
>   
>           default:
> -            fprintf(stderr, "Bad state!\n");
>               g_assert_not_reached();
>           }
>   
>           if (again < 0 || itd_count > 16) {
>               /* TODO: notify guest (raise HSE irq?) */
> -            fprintf(stderr, "processing error - resetting ehci HC\n");
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "processing error - resetting ehci HC\n");
>               ehci_reset(ehci);
>               again = 0;
>           }
> @@ -2181,8 +2189,6 @@ static void ehci_advance_async_state(EHCIState *ehci)
>   
>       default:
>           /* this should only be due to a developer mistake */
> -        fprintf(stderr, "ehci: Bad asynchronous state %d. "
> -                "Resetting to active\n", ehci->astate);
>           g_assert_not_reached();
>       }
>   }
> @@ -2231,8 +2237,6 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
>   
>       default:
>           /* this should only be due to a developer mistake */
> -        fprintf(stderr, "ehci: Bad periodic state %d. "
> -                "Resetting to active\n", ehci->pstate);
>           g_assert_not_reached();
>       }
>   }

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


