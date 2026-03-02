Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383C1EB3636
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 21:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxAyp-00048s-A9; Mon, 02 Mar 2026 16:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxAyl-00048j-0p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:39:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxAyj-0005nv-EJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:39:02 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622Jujiw2504678
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 21:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qL231AvH/ErEeNYnS+y+OIUNn9Iz2WaUeEZMchhqMFY=; b=UccbF9/EwJ2LYZ8b
 JQj8T66w6Z6qSutuJEgZYU78LMxa7i79hHaOCeosjeTPSeZCA3jElaA8dBvwC38T
 rvz0vxlcPKvxKzdiFb2Mov5f98i1TTuQiwe5jCcXDmEDOI7ySTd526VyeLlLiv2o
 4CfwBU/VncJ8Jb68RgmR9MUJfba2TELnXCE4JqfzsRx/W8cKFdXxFRFqCcKlDPsn
 iFqRzpvTxRqWyuu693srzapOZNiIFvoAF4EPuMXbCmk1exhaDkFS8P6xa63qDQIE
 ysFz7Nib0YMOu8rTT6KdKQwPsPctArv4hHM/ViJnCi++j8JeWjO8xccALDloWtu8
 +u06bg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5heu1j1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 21:38:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdff07d8f4so2646954eec.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772487537; x=1773092337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qL231AvH/ErEeNYnS+y+OIUNn9Iz2WaUeEZMchhqMFY=;
 b=Ltw23vyxzKRzpEjhad0W4iufrqmtz/KoZuXIsse58+Nuz8XQy7xS6zay0x15LtL41s
 hy/FhnrwIEu3/h++2CL4VWgVpNHUykROaMpnePSNMMP2tz3R5addoJcRruAfAyiNqUZq
 F5Jzn3lqeSZok/AxIRCuZBoMzwQnvjPCIvXDZPGoscG0vspDPmmBKYr1TAM3x559d05N
 BvwUCQepJqoXxfeAL+kyNes9rwqnJSM7t0boBUN6DsceeWCC/dw+B5lrke6t64kh29fE
 6ffIHHgpQIqMCxU3TzQJhQk778XTD95occ/TPcU+ubcEoYyOs/bmVa5f07+8hucPzxOe
 VLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772487537; x=1773092337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qL231AvH/ErEeNYnS+y+OIUNn9Iz2WaUeEZMchhqMFY=;
 b=alePjRCmBU7eb0oYDRG8o5AXrCV15oS2VTNuIb3C0sUqliyrsOd+2cxk8AQNE+CiMq
 0Hi8HXBnigmvITTaqlZq1Jx29SoBJZEynta+GCJPUOcdCOA8gJJVd/EubiZQiMWYFzEz
 dYR3WASZFMdZLL7nIJt86EqPU448x+2aszLN04wdw9fCwtsWZ0YPrEUDKmPXqJLFnrsU
 VVdkEIcpW0+UxozHq9PSaKtjjnrNJiPpjPkxOSidjYdFdbBaUlUScuak3wl4HFs4bn/O
 ftDWY0Pavqxp89WfKBv45zbJsPU4OYHHUxv2mESUuc4I/8FLT+np9qNI5jRZQwL1takE
 gJwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvEF38UgMiydg/KpkP/59HqkbuLn+ZkmmqPc/MEOC8Paq20DH6bWlOR4NHGPRFJp6dcNbkb+Mp0L1B@nongnu.org
X-Gm-Message-State: AOJu0YzoXkXOSWinF2Q8iYqUR37skcedfxD9IYrHclCD8evmSFNHy1RF
 qNFfRstdVLIjUe0cyaoS6VJet9NEUi8OIkazhubyjcaKyl+cPWPtNr+pPCuiZzK7JHaReSajW9v
 7ftUroTEB4ygfg672IaY5ehAEjhTJ0XCilJzdQBimZnlH9nku4bzuwUMLYQ==
X-Gm-Gg: ATEYQzz/zwuMEfMdS6DHPHkmxDLqLFLVgXbpRvsbyEkVfJkuTx5stIKmnwN7UwR+auI
 pbspcSfSfOL3HblXvKF3/b+L2Oq1hXTy3RC77pba6iOWoBpUltg1O0BYmh4CUQ6+0bu/utkRcd+
 FbYwXmTA2yFs8n/RmpINkNpFOWusKsVnT/6SaeHK6ppAdrJ6qZCx/4HI5aVqkkM7NiQ0YbRlSY3
 qrUqRNbvJxtt1y3s2rFsP8gxnTPAq5q8OVSzGJYr/WcBI10kGfBAabyyW2jKwF7Z2r1DvyHekw0
 vIm5vyi5wmCjQyeGMH9ueZer60tfQd0jaxsBNgVqvHUJWEBcD7MLY06OA2VExS2gXSEvqqtwHka
 1jIeCsJzUIYxLjykxuVUXm9Jo6/TDwbHbMLndKWBgiGVjhZ6MARATYwYMd4SnDoLKmLTq7N9DLC
 nH
X-Received: by 2002:a05:7022:113:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-1278fc4dac8mr5445582c88.34.1772487537251; 
 Mon, 02 Mar 2026 13:38:57 -0800 (PST)
X-Received: by 2002:a05:7022:113:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-1278fc4dac8mr5445570c88.34.1772487536700; 
 Mon, 02 Mar 2026 13:38:56 -0800 (PST)
Received: from [10.110.0.81] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899df36asm15217971c88.4.2026.03.02.13.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 13:38:56 -0800 (PST)
Message-ID: <908abf8b-e5d6-40f3-8869-75ce42e632d0@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 13:38:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX
 callback to fix trace reporting
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
 <20260302032626.1974743-3-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260302032626.1974743-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a60372 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=VDQsAdnQChltgqqKT-AA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: -wnBecmm-NASmGvwnY11px2diezV9xKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MiBTYWx0ZWRfX1ZqaadrIBgNr
 nCd9iNsV4Vf/OxdZDpcw0EAvIpgINPjETp+x/LiIx8Y+oYV2Z4lbUz509D9RaTTcTngKceU9Pt6
 cC7De3vs14z56O3M6vOeZ8uM7TIiRc0o4TgrbHaWRLDECEe6GjV/aIhL4e6+28RXmjS5fUQ/Lxy
 Ifw33dt9ZmokErkRNGpuTMPw5TAy8PasWJ+T7Qqk8cQ+pnwpWf9GZZt62JqLg/ByokXGLudnmr2
 2A4t5Dgc+mqNAL2H5YgMwofDjbsA3Jq78CzwRtwjFGdn+6SeqnojEMe94bUDn8LrloIEPoqklCY
 7BfNQFGh2ZVYVBVBJ9+EwSET1qlDCr/Hmp9u4eTA0PErAbS5/Noz9C3dAAhOjpZAY8ecNxB/w4d
 HKxbbEqRzlqtGT7bSm0hiodFD2tej4Ow3q51hMjduza/vdG9dCyc/A+EBMoQV9Ph24IdWuJkQij
 jqIq7sfpcfoLHCo/xtw==
X-Proofpoint-ORIG-GUID: -wnBecmm-NASmGvwnY11px2diezV9xKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020162
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/1/2026 7:26 PM, Jamin Lin wrote:
> mock_i3c_target_tx() did not update *num_sent before returning.
> 
> Although some callers may not directly use this value, i3c_send()
> passes num_sent to trace_i3c_send(). If the target TX callback does
> not initialize *num_sent, the trace output may report an incorrect
> or uninitialized value, leading to confusing debugging information.
> 
> For example, the following trace was observed:
> 
>   mock_i3c_target_tx I3C mock target write 0x12
>   i3c_send I3C send 0/1 bytes, ack=1    (expected 1/1 bytes)
> 
> This happens because *num_sent was never set by the TX callback.
> 
> Fix this by setting:
> 
>   *num_sent = to_write;
> 
> so that the actual number of transmitted bytes is correctly
> propagated back to i3c_send() and reflected in trace output.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/i3c/mock-i3c-target.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c
> index 875cd7c7d0..5c913ee49b 100644
> --- a/hw/i3c/mock-i3c-target.c
> +++ b/hw/i3c/mock-i3c-target.c
> @@ -86,6 +86,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
>          s->buf[s->p_buf] = data[i];
>          s->p_buf++;
>      }
> +    *num_sent = to_write;

Thanks for fixing this... could you also set *num_sent to 1 in the ibi return path earlier in the function (snippet below), where it seems to consume exactly 1 byte of data
...

<snip>
    if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
        mock_i3c_target_ibi_timer_start(s);
+	*num_sent = 1;
        return 0;
    }


</snip>

>      return ret;
>  }
>  

Jithu


