Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1909ACC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGf4A-0006mo-Dv; Tue, 13 Oct 2026 12:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGf46-0006mD-88
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:09:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGf40-00015R-Qd
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:09:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE4fqX2512286
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 16:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KMVe3t60wa+MmYIw+ZlMJIASois2W02TkSrsjJP8iuA=; b=VCvSluDab7vS3tyF
 IVlj19Dn3rhAZ05OwsoX1McHozwiRmDuX3WW3MweD04sw2VW7l1cl7gWL4AxZ2ho
 qi8/Al29jIRjSzRJWeGDBcVwszYzjSzO6YKrQ0MhxZXfV3aNv9r0RNnOtTk3B5Kj
 1gJx+sf5fzZnaE4zE9cMWNIQKno+lC0Wkb7CpB9TdLNHcC5CG52fQXp+9EKgklsX
 /ppKlLCte0st+B1+4W1EBCY27janKT/SfU+UuaJSez7O9YBnseM0/fRSE9RERFTf
 2n8TklaOzxn8oWRHnLmfpQGIoOFJ22wbVEa8A17c81f7phWQHfBIj7v5kx0/c5N/
 APhngA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1uwng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 16:09:14 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5e24d542d40so3874001e0c.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791907753; x=1792512553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KMVe3t60wa+MmYIw+ZlMJIASois2W02TkSrsjJP8iuA=;
 b=QXZUFSUiuLV+4DxWfTJUf+zfYRoy75rvnTtSNnxfa4Kb0xbTXzkCRbKsIJSk/LWpkS
 sdBtP0XmLs01ANyyNdv9QUGEbcL1eMR71ISy4nPWBxATYhoaJ8+FXBDkIORYzOS2jnKu
 6lKODIRXV79SvhcqFIx3hVB39XR9dL5FrsXI/kkNfQBgil7epaIZ+agpmLIsHDZ12ZFD
 8wMpPcuNAr4PXLGy7FfhrygG2vVSHXsg+eVuu+kGaMjtTuwEy21zpD238EWTuBlVrY6m
 3+8j9MBcK2Ce8mU/1Gq43R8ZzffHm4A027WPhhw94xTgxg0YLfXSdFXqAQ1V5oUliLYQ
 6sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907753; x=1792512553;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KMVe3t60wa+MmYIw+ZlMJIASois2W02TkSrsjJP8iuA=;
 b=SRGGeoCebZpbjrf1EFW9vIa5el1ext73cv7A6VRhACbe41bO28COMDYJsbSg5WL9Zq
 aRT6icXtQgpYI6ionycxX9OzW9f+y1/begwkt8GMzDESwer6atKByQ3V6rMIdtiDvZeY
 iokq5C0uoXn6NnDooPbwOuTSTcnsDxJblfG7C2hC02cgIRcmtVeXLkJnGigDtltwUPH2
 q8Jl0eBha61WHtR4IglX8GMP7yjeoOSYLV0LDKoY4za3wSehGNCsCX9HU2kkpzOxwKjE
 ZuTHw6UGM8WnfaKUiL/yuq7+//S2n49RyvRyq6dgoVwjFqdz11EAy8O/CHgztwu/Yx28
 IyCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtzZKkz50SfBUZOW6SYxGgt4pgkP5FQ6fdGBN1aZVPdpD7UoQr5DlVqX4Zk7qvkoC4TVZBbz3dMixT@nongnu.org
X-Gm-Message-State: AFq9FYIaCuN3WG4vrPwrLg9kWAdQMcRsxSuEiE5brvgqxC8l+V0ZXys0
 Hy2ebTDfAI/bBqiuLquTXlwtDaTELDDyO/DcTFf5ztHlWrV+729/w18s4aFUXSX6HOMB8lzDZV8
 MKEqc7oI0aNWFJbMqrc7EcsMVjFxAWw4MvrBtMs2sgAOpcClKGSOfmQiITA==
X-Gm-Gg: AYBFou3ZnCCoQhZS5rMAAGLqKtz1VEo5IibDyoMVWVdlQi/s2IXbcW/cHuPThWsAa+E
 BlILFoicdSsS0IFzn2xMMtKQj/LZe/J/3GheA8MA45GV00RswUbzY6FgrMgaEstNzKZ/vxtfgKo
 Q95HDXbaPto9AZcziatE8cm8WSpgEp8w/gtQv7p/j9SV6yQFGFjhKWyznqWUyvtqYjknlDwS4Ib
 Sv/Dx3EcfIfxB+C0JIBKuUasYuutb7cYv9Iq704+Z+054Zhk/nWBxpbyMitnqbSixHpoX6hektX
 0GWsL4bA/RX/e3ZaBOeySv2OJAmoXxmrNOMK1tArkOgjA6aZEhDk9byODt2SIh75BPtFSV50kGt
 rpZeLRkKxwi+qoG89QtqAhA==
X-Received: by 2002:a05:6122:62b1:b0:5cf:2d4a:42c3 with SMTP id
 71dfb90a1353d-5e91f4e1fd8mr4880123e0c.19.1791907753336; 
 Tue, 13 Oct 2026 09:09:13 -0700 (PDT)
X-Received: by 2002:a05:6122:62b1:b0:5cf:2d4a:42c3 with SMTP id
 71dfb90a1353d-5e91f4e1fd8mr4880064e0c.19.1791907751694; 
 Tue, 13 Oct 2026 09:09:11 -0700 (PDT)
Received: from [10.111.130.93] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19c71a1d7sm187097165e9.5.2026.10.13.09.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 09:09:11 -0700 (PDT)
Message-ID: <8f0cfc4a-060c-41a9-81e4-111e0019392f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 18:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] hw/core: Implement Remote Port Memory Master bus
 transactions
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
 <20260915160044.345788-12-ruslichenko.r@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915160044.345788-12-ruslichenko.r@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace57aa cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=DBfv99YmAAAA:8 a=zd2uoN0lAAAA:8
 a=yC-0_ovQAAAA:8 a=IDb8sxtT3DtX1KZi91YA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: hep8zECMpbbLkU_kaGO2NZxYF5YNIsLI
X-Proofpoint-ORIG-GUID: hep8zECMpbbLkU_kaGO2NZxYF5YNIsLI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NCBTYWx0ZWRfX1vsJidH+SBIE
 qhm+21pafeir49MCDSgHQzwEyzidFXHb2iT7/WHgqCfUjJx4FG87Q8rGkzWE9FLNQVBPh1j2Tik
 3j/TpzAq9KjUmW88xz25u0vSev/Ypr0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NCBTYWx0ZWRfX8tmXijIPrkUU
 ozFuwDH3xbYgyYV02Ake0k8XkwNWrMSfe6xxV0Z51xA5sIuJePTZqQKLhqkRyqPFXsJqEqMMfs9
 eklZdqLjL+odG0rmwc/lanqlx5eP/f8eE4IVJk9YVkJ6O+8l7tvpIYRmIiLiO9yayx3OiJDGxkc
 6nEqPSxwCWWin25UmSTQnnhd58RG+DA5pg2G9b2ieAseHKwyQkw0IhjnlXUq8udjpKdlDEB/X/d
 CQbmFUJF21R7b4HT7g6cHRxlXxSP8yduGEHlJyNXsANF2OS01qUML+MYs4+RTVjq908dd+kUlph
 ZMeXUfSXNyWpMjiym2Ho74xWIFRZ8cJQksNqvIsD8ZH1WhGmkepUA7hAseeuXDnssBHUVB98gMX
 FuBgOn+B7KfSJKK5GtmvB/aakL7Rl+ealeoK+N94gxMxMGJBvAc0qDmGIhcvI/c9IcSEYFH636w
 oFNnThzAqH0jSiyRrzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130064
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

Hi,

On 2026-09-15 18:00, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> 
> Implement the core access handlers for the Remote Port Memory
> Master device, which enables QEMU to initiate memory-mapped
> transaction to remote peers.
> 
> The patch adds support for:
> - Translation of QEMU memory region read/write into Remote Port
> read/write packets
> - Support for propagating of transaction attributes
> (Secure, MasterID)
> - Synchronous response waiting with optional timeout (timeout
>    configuration to be added within later patches)
> - Add trace events for monitoring TX/RX bus transactions
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>   hw/core/remote-port-memory-master.c | 191 +++++++++++++++++++++++++++-
>   hw/core/remote-port.c               |   5 +
>   hw/core/trace-events                |   4 +
>   include/hw/core/remote-port.h       |  11 ++
>   4 files changed, 207 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
> index 4b0283f9fe..41ef1df518 100644
> --- a/hw/core/remote-port-memory-master.c
> +++ b/hw/core/remote-port-memory-master.c
> @@ -29,18 +29,201 @@
>   
>   #define RP_MAX_ACCESS_SIZE 4096
>   
> +static int rp_mm_get_timeout(RPMemoryTransaction *tr)
> +{
> +    RemotePortMap *map = tr->opaque;
> +    RemotePortMemoryMaster *s;
> +
> +    if (!map || !map->parent ||
> +        !object_dynamic_cast(OBJECT(map->parent),
> +                             TYPE_REMOTE_PORT_MEMORY_MASTER)) {
> +        return 0;
> +    }
> +    s = REMOTE_PORT_MEMORY_MASTER(map->parent);
> +    return s->rp_timeout;
> +}
> +
> +MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
> +                                       struct rp_peer_state *peer,
> +                                       RPMemoryTransaction *tr,
> +                                       bool relative, uint64_t offset,
> +                                       uint32_t def_attr)
> +{
> +    uint64_t addr = tr->addr;
> +    RemotePortRespSlot *rsp_slot;
> +    RemotePortDynPkt *rsp;
> +    struct  {
> +        struct rp_pkt_busaccess_ext_base pkt;
> +        uint8_t reserved[RP_MAX_ACCESS_SIZE];
> +    } pay;
> +    uint8_t *data = rp_busaccess_tx_dataptr(peer, &pay.pkt);
> +    struct rp_encode_busaccess_in in = {0};
> +    int i;
> +    int len;
> +    int rp_timeout = rp_mm_get_timeout(tr);
> +    MemTxResult ret;
> +
> +    if (tr->rw) {
> +        /* Data up to 8 bytes is passed as values.  */
> +        if (tr->size <= 8) {
> +            for (i = 0; i < tr->size; i++) {
> +                data[i] = tr->data.u64 >> (i * 8);
> +            }
> +        } else {
> +            memcpy(data, tr->data.p8, tr->size);
> +        }
> +    }
> +
> +    addr += relative ? 0 : offset;
> +
> +    in.cmd = tr->rw ? RP_CMD_write : RP_CMD_read;
> +    in.id = rp_new_id(rp);
> +    in.dev = rp_dev;
> +    in.clk = rp_normalized_vmclk(rp);
> +    in.master_id = tr->attr.requester_id;
> +    in.addr = addr;
> +    in.attr = def_attr;
> +    in.attr |= tr->attr.secure ? RP_BUS_ATTR_SECURE : 0;
> +    in.size = tr->size;
> +    in.stream_width = tr->size;
> +    len = rp_encode_busaccess(peer, &pay.pkt, &in);
> +    len += tr->rw ? tr->size : 0;
> +
> +    trace_remote_port_memory_master_tx_busaccess(rp_cmd_to_string(in.cmd),
> +        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
> +
> +    rp_rsp_mutex_lock(rp);
> +    rp_write(rp, (void *) &pay, len);
> +
> +    if (!rp_timeout) {
> +        rsp_slot = rp_dev_wait_resp(rp, in.dev, in.id);
> +    } else {
> +        rsp_slot = rp_dev_timed_wait_resp(rp, in.dev, in.id, rp_timeout);
> +        if (rsp_slot->valid == false) {
> +            /*
> +             * Timeout error
> +             */
> +            rp_rsp_mutex_unlock(rp);
> +            return MEMTX_ERROR;
> +        }
> +    }
> +    rsp = &rsp_slot->rsp;
> +
> +    /* We dont support out of order answers yet.  */
> +    assert(rsp->pkt->hdr.id == in.id);
> +
> +    switch (rp_get_busaccess_response(rsp->pkt)) {
> +    case RP_RESP_OK:
> +        ret = MEMTX_OK;
> +        break;
> +    case RP_RESP_ADDR_ERROR:
> +        ret = MEMTX_DECODE_ERROR;
> +        break;
> +    default:
> +        ret = MEMTX_ERROR;
> +        break;
> +    }
> +
> +    if (ret == MEMTX_OK && !tr->rw) {
> +        data = rp_busaccess_rx_dataptr(peer, &rsp->pkt->busaccess_ext_base);
> +        /* Data up to 8 bytes is return as values.  */
> +        if (tr->size <= 8) {
> +            for (i = 0; i < tr->size; i++) {
> +                tr->data.u64 |= ((uint64_t) data[i]) << (i * 8);
> +            }
> +        } else {
> +            memcpy(tr->data.p8, data, tr->size);

I don't understand this direct memory access.

Shouldn't this be handled by the FlatView and end as a subpage_t
leaf instead?

Doing some archeology to understand:
https://lore.kernel.org/qemu-devel/20170204115048.GM12995@toto/

Amusingly a related backtrace:
https://lore.kernel.org/qemu-devel/CAKmqyKOqbJ+-t0SeyZDzDM9RLEQX63WM3-wyJTbiMGHRKtHPYQ@mail.gmail.com/

> +        }
> +    }
> +
> +    trace_remote_port_memory_master_rx_busaccess(
> +        rp_cmd_to_string(rsp->pkt->hdr.cmd), rsp->pkt->hdr.id,
> +        rsp->pkt->hdr.flags, rsp->pkt->hdr.dev, rsp->pkt->busaccess.addr,
> +        rsp->pkt->busaccess.len, rsp->pkt->busaccess.attributes);
> +
> +    if (rp_timeout) {
> +        for (i = 0; i < ARRAY_SIZE(rp->dev_state[rp_dev].rsp_queue); i++) {
> +            if (rp->dev_state[rp_dev].rsp_queue[i].used &&
> +                rp->dev_state[rp_dev].rsp_queue[i].valid) {
> +                rp_resp_slot_done(rp, &rp->dev_state[rp_dev].rsp_queue[i]);
> +            }
> +        }
> +    } else {
> +        rp_resp_slot_done(rp, rsp_slot);
> +    }
> +    rp_rsp_mutex_unlock(rp);
> +
> +    /*
> +     * For strongly ordered or transactions that don't allow Early Acking,
> +     * we need to drain the pending RP processing queue here. This is
> +     * because RP handles responses in parallel with normal requests so
> +     * they may get reordered. This becomes visible for example with reads
> +     * to read-to-clear registers that clear interrupts. Even though the
> +     * lowering of the interrupt-wires arrives to us before the read-resp,
> +     * we may handle the response before the wire update, resulting in
> +     * spurious interrupts.
> +     *
> +     * This has some room for optimization but for now we use the big hammer
> +     * and drain the entire qeueue.
> +     */
> +    rp_process(rp);
> +
> +    /* Reads are sync-points, roll the sync timer.  */
> +    rp_restart_sync_timer(rp);
> +    return ret;
> +}
> +
> +MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
> +                         struct rp_peer_state *peer,
> +                         RPMemoryTransaction *tr,
> +                         bool relative, uint64_t offset)
> +{
> +    return rp_mm_access_with_def_attr(rp, rp_dev, peer, tr, relative, offset,
> +                                      0);
> +}
> +
>   static MemTxResult rp_mm_read(void *opaque, hwaddr addr, uint64_t *data,
>                                    unsigned size, MemTxAttrs attrs)
>   {
> -    /* TBD */
> -    return MEMTX_OK;
> +    MemTxResult ret;
> +    RemotePortMap *map = opaque;
> +    RemotePortMemoryMaster *s = map->parent;
> +
> +    RPMemoryTransaction tr = {};
> +
> +    tr.opaque = map;
> +    tr.rw = false;
> +    tr.addr = addr;
> +    tr.size = size;
> +    tr.attr = attrs;
> +
> +    ret = rp_mm_access(s->rp, s->rp_dev, s->peer, &tr, s->relative,
> +                map->offset);
> +
> +    if (ret == MEMTX_OK) {
> +        *data = tr.data.u64;
> +    }
> +
> +    return ret;
>   }
>   
>   static MemTxResult rp_mm_write(void *opaque, hwaddr addr, uint64_t data,
>                                     unsigned size, MemTxAttrs attrs)
>   {
> -    /* TBD */
> -    return MEMTX_OK;
> +    RemotePortMap *map = opaque;
> +    RemotePortMemoryMaster *s = map->parent;
> +
> +    RPMemoryTransaction tr = {};
> +
> +    tr.opaque = map;
> +    tr.rw = true;
> +    tr.addr = addr;
> +    tr.size = size;
> +    tr.attr = attrs;
> +    tr.data.u64 = data;
> +
> +    return rp_mm_access(s->rp, s->rp_dev, s->peer, &tr, s->relative,
> +                    map->offset);
>   }
>   
>   static const MemoryRegionOps rp_ops_template = {
> diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
> index b4c9fa1528..6a6effdd19 100644
> --- a/hw/core/remote-port.c
> +++ b/hw/core/remote-port.c
> @@ -39,6 +39,11 @@ static void rp_event_read_and_process(RemotePort *s);
>   static void sync_timer_hit(void *opaque);
>   static void syncresp_timer_hit(void *opaque);
>   
> +uint32_t rp_new_id(RemotePort *s)
> +{
> +    return qatomic_fetch_inc(&s->current_id);
> +}

