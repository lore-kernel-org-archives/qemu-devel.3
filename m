Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01896C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTva-00065X-Ba; Thu, 18 Apr 2024 11:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rxTvY-000658-2D
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:43:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rxTvU-0001DG-5y
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:43:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 33BC75FD22;
 Thu, 18 Apr 2024 18:43:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A45F7B9273;
 Thu, 18 Apr 2024 18:43:42 +0300 (MSK)
Message-ID: <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
Date: Thu, 18 Apr 2024 18:43:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

06.02.2024 10:13, Cord Amfmgm wrote:
> This changes the ohci validation to not assert if invalid
> data is fed to the ohci controller. The poc suggested in
> https://bugs.launchpad.net/qemu/+bug/1907042
> and then migrated to bug #303 does the following to
> feed it a SETUP pid and EndPt of 1:
> 
>          uint32_t MaxPacket = 64;
>          uint32_t TDFormat = 0;
>          uint32_t Skip = 0;
>          uint32_t Speed = 0;
>          uint32_t Direction = 0;  /* #define OHCI_TD_DIR_SETUP 0 */
>          uint32_t EndPt = 1;
>          uint32_t FuncAddress = 0;
>          ed->attr = (MaxPacket << 16) | (TDFormat << 15) | (Skip << 14)
>                     | (Speed << 13) | (Direction << 11) | (EndPt << 7)
>                     | FuncAddress;
>          ed->tailp = /*TDQTailPntr= */ 0;
>          ed->headp = ((/*TDQHeadPntr= */ &td[0]) & 0xfffffff0)
>                     | (/* ToggleCarry= */ 0 << 1);
>          ed->next_ed = (/* NextED= */ 0 & 0xfffffff0)
> 
> qemu-fuzz also caught the same issue in #1510. They are
> both fixed by this patch.
> 
> The if (td.cbp > td.be) logic in ohci_service_td() causes an
> ohci_die(). My understanding of the OHCI spec 4.3.1.2
> Table 4-2 allows td.cbp to be one byte more than td.be to
> signal the buffer has zero length. The new check in qemu
> appears to have been added since qemu-4.2. This patch
> includes both fixes since they are located very close
> together.
> 
> Signed-off-by: David Hubbard <dmamfmgm@gmail.com>

Wonder if this got lost somehow.  Or is it not needed?

Thanks,

/mjt

> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index d73b53f33c..a53808126f 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,
> struct ohci_ed *ed)
>       case OHCI_TD_DIR_SETUP:
>           str = "setup";
>           pid = USB_TOKEN_SETUP;
> +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed to ep 0 */
> +            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
> +            ohci_die(ohci);
> +            return 1;
> +        }
>           break;
>       default:
>           trace_usb_ohci_td_bad_direction(dir);
> @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> ohci_ed *ed)
>           if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
>               len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>           } else {
> -            if (td.cbp > td.be) {
> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> +            if (td.cbp > td.be + 1) {
> +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
>                   ohci_die(ohci);
>                   return 1;
>               }
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index ed7dc210d3..b47d082fa3 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)
> "DataOverrun %d > %zu"
>   usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
>   usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
>   usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
> +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp = 0x%x > be = 0x%x"
> +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad
> pid %s: ed.flags 0x%x td.flags 0x%x"
>   usb_ohci_port_attach(int index) "port #%d"
>   usb_ohci_port_detach(int index) "port #%d"
>   usb_ohci_port_wakeup(int index) "port #%d"
> 


