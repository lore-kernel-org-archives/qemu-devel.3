Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1026DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgden-0004V0-J2; Mon, 06 Jul 2026 03:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdeC-0004My-My
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:22:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdeB-0007MH-1z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:21:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66678FB63976365
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6F71qfZ845X/x6cRIHWLh6qyt9/ZBJFHShkh1JQVSwI=; b=MYPTDLLrDM9EH1Lp
 VTunfE4QXPYDhrt8SUy8IzsTSiM/bR1pmakvlgA7P9pdOYrk6sXep/jm9Vi0ph9X
 7qefdm9y62/gyXwtDG5kfA7k1bFeETIkn4d4lPub6GCj+lCagpqS//l+uh6f7PMr
 pkkFsCMEHVHX6cz/f/5RvjdM2YllNIEqF71vsOU1ZfZjbYnPFWoglfv/78cVV1D7
 ca0odBN1SWiAV0Udk+8osQlttPjxdNpJZpKRSooFRu+60Sz/4aj01pWnt9hVw3+4
 EnLLoeYHctk2pi9F19A9s3nV6QvUfjzAt5Duny96MGL+aib50/0jV8uGyg1xpTx5
 o18ziw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7g1f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:21:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e695a3b28so361441585a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783322501; x=1783927301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6F71qfZ845X/x6cRIHWLh6qyt9/ZBJFHShkh1JQVSwI=;
 b=es+Utv5+bbdoDeWFO7CcCYVYeF740IIrX0Ht4UZL/5mfTxHERdqotFoMb0j4pGdPVg
 31kaVO7ldpm04csZkwFfHqUImuNwK/2G722WlITnbdFB4zpWuRUWvuv+0UFW68EetI/5
 EBy2DEEeibJE7bk2hf5Wh1EvGvmjs3f8OyEsb+wLbAD4JIZW5Uz7wIVHVm+1GWpq88Pk
 7h3LzD4jkwKXtJp2G2jRoYSc//20PvczqGbjc1jMLxBfgMKYAevEVqlm6sIKcNAKnFiC
 sXTZWQRwHx6Y3ZHjy/jWwTp/a2YDgYBhAiPlZh79H0qasjhfLqAkGjfukzp+sVfGLBEx
 CZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783322501; x=1783927301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6F71qfZ845X/x6cRIHWLh6qyt9/ZBJFHShkh1JQVSwI=;
 b=T+OapSgncIcdYQtHbdvJ7CC9R4bEB4GqDBhpJkfTZXhvQGeDJYZg8wdUXV0LaXTEUi
 sqfRymwHLL1o98PHZGhjliFWfmKEtTbvX7me3EimCpN3cWwxki8xZEg33lZ2xlZqDMNX
 DpEyoeEZVDsWBZXJ1izLGnFh+BPJ8sA9Y7o9AEVVy8V+7zIZw+JYuoFa6wLL+1Yz9hqy
 1uhRvD+ft0FnsHVYJ6E6yXXYd7KFTu+iMbbLhwwIx05nfn6J7q6AhTEBBmaMXvb1mrM4
 vnvCNtN2A5u0ESMDYMToUFgxI+lwmv2RhmWE8LHit/Q64txG3wXJAAtVlBuWl+bL4tB2
 6Kpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSMQUsjOkz2BLYoJbkW6mxi2QtiiokzxBozWkGUtfXyP/bdgst4TCh/jkqSNvdlc7N/6ltvqnmq5Im@nongnu.org
X-Gm-Message-State: AOJu0YwSKUIvoTQYPLu/TJhJJ7GWNEvKza5cC75jVqsfpHYxpYaB2IwW
 Ov1N+TMfkJNiGrFe4b4fMW8wqPI43EbwsHRxfyH1wW0BnprG/0sMX/f/0i7wAiCHoNl6v0MWKHw
 t6TRHOfnlooMEAUkAhZOQStSUOt1kSc4BJJCE9SCxQmM9AIHidOk4Hxs/FA==
X-Gm-Gg: AfdE7cncemZhW8cvebOnG7sw5HdLtnRXnyY5QgusrJpe8BlWo7zx+d0hPvMcHoarLA9
 DurUCBDbMx826cX2wvVXc/MbxiAG9ukliEJr2eGpUnv70QLnBjHl66SAJT9sHZvuhDYneiPnBfL
 v/iATU/PktguYNE1wEBtBp+UV2AWEXeHwm5su3c3xlW3hmzaxlazjcrsRsxabZO3ZpPuk6Qbt7u
 dwnDYi2p9jK2t71enub47q6R3BWtyJaYFrnz0scuxRebS6g/vEACC7K8l8PrSQpSfTx6bg7MCk5
 zrqF1cdZvULU5ZDsmzMDxN4z+N797IRnigHPKg9ttSsHZ4GoDuv+dkvyRUYH1Am0GbVgOnINIKE
 8hkOCd/0+u8Drp1ZwbqhXvWgODj/PdABUrRZX99pOduYXvJofKn9h3/0w1QYpQA==
X-Received: by 2002:a05:620a:261c:b0:92e:650f:c39c with SMTP id
 af79cd13be357-92e8b25d442mr1623398785a.3.1783322500798; 
 Mon, 06 Jul 2026 00:21:40 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:92e:650f:c39c with SMTP id
 af79cd13be357-92e8b25d442mr1623396985a.3.1783322500328; 
 Mon, 06 Jul 2026 00:21:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm21398413f8f.29.2026.07.06.00.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:21:39 -0700 (PDT)
Message-ID: <ce8ebeb2-2509-48be-9ea1-afee614859a8@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/ide/ahci: cancel in-flight buffered reads on
 command engine restart
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org
References: <20260619112158.304782-1-den@openvz.org>
 <20260619112158.304782-2-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260619112158.304782-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfX/zqGxCqTVf32
 +ogZcKEpVZe3rASHw0ayoeGycxOITNPuwiaaTX3kqiIArwTA1H0zCv7foR+UDNRnN81OtJTBzac
 pkwP2WoU97RvpVNFlJPPDQRuxFQdebW0xX8JTQjDynGo0NwAv/7KMW48Z3Uw5M+dvQ/kQaNEnIl
 Ypm0HOl3H+yN8BKvQxlNdL8LxIXsz8fXhtCvRm2Lx5pNmJMIBcRDluyGZjXvQx1S2Lnhm0dVWfa
 2Qh64RB6MNlAuayhaDrRe+yfUkYYDD9846N5bmgn+bgSfHliR4WYVUCThzvJyeJrwsXyStAsjUL
 zkOIWSKuu5B7+Mg8xVsIUYzvpkaURBfys+1ktWR9nxb3TPd+9Am9vM1C7khxSNVAE8SJ5bibDfs
 7hqf3ImeWRNCQmeo8Gimbv0HUfMqGeZlY2c1IJc2JHBkr6M+acNrGOfhOS802+zJwFtMJzYcD4Y
 WqEZ2hpcZSAW/FwGqMQ==
X-Proofpoint-ORIG-GUID: ccTe95N04Jw2nMZFk631mmIWQFdZqKFB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfX37OvZqtY27G4
 Ik9o+2EacNlZcFn3uKro/CpkvLJbQB3HweiQzQ+9r+h/vZNDL9/joVuYqENUwWK/tzaN9UIjTpE
 +OdZCaQT4RX2VibqWuG81BjEcHRVrek=
X-Proofpoint-GUID: ccTe95N04Jw2nMZFk631mmIWQFdZqKFB
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4b5785 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6rqHouBjAAAA:8 a=OaVDtTZfmeb8DBWjp6AA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Denis,

On 19/6/26 13:21, Denis V. Lunev via qemu development wrote:
> ATAPI CD reads are issued through ide_buffered_readv()
> (cd_read_sector() and ide_atapi_cmd_read_dma_cb() in hw/ide/atapi.c).
> The PIO path discards the returned aiocb; the DMA path stores it in
> s->bus->dma->aiocb.
> 
> A guest can stop and restart a port's command engine
> (PxCMD.ST 1 -> 0 -> 1) while such a read is still in flight. Stopping
> the engine unmaps the command list (ahci_unmap_clb_address()) and
> restarting it re-maps the list and clears AHCIDevice.cur_cmd to NULL,
> but nothing tears down the outstanding read. This path does not run
> ide_reset(), so the drive's transfer state is preserved and the read
> still completes. Its callbacks then dereference the stale or NULL
> cur_cmd in the AHCI transfer helpers:
> 
>    PIO: cd_read_sector_cb() -> ide_atapi_cmd_reply_end() ->
>         ide_transfer_start_norecurse() -> ahci_pio_transfer()
> 
>    DMA: ide_atapi_cmd_read_dma_cb() -> ahci_dma_rw_buf() ->
>         ahci_populate_sglist()
> 
> Both crash with a NULL cur_cmd; the PIO variant has been seen in the
> field.
> 
> Cancel the outstanding I/O when the command list is unmapped, reusing
> ide_cancel_dma_sync() as the ATAPI DEVICE RESET command does. It runs
> the completion callback with -ECANCELED (which tears down
> s->bus->dma->aiocb for the DMA case) and orphans the buffered request,
> so the eventual asynchronous completion is a no-op. Merely setting the
> orphaned flag is not enough: it would leave s->bus->dma->aiocb pointing
> at a freed aiocb that a later reset would cancel.
> 
> Fixes: 1d8c11d63154 ("ide: add support for IDEBufferedRequest")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/ahci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index c2b4432b94..8e3684cd3c 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -740,6 +740,9 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
>   
>   static void ahci_unmap_clb_address(AHCIDevice *ad)
>   {
> +    /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
> +    ide_cancel_dma_sync(&ad->port.ifs[0]);

ide_bus_active_if(&ad->port.ifs) would be safer, otherwise the
patch looks reasonable.

> +
>       if (ad->lst == NULL) {
>           trace_ahci_unmap_clb_address_null(ad->hba, ad->port_no);
>           return;


