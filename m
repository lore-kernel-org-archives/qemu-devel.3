Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E09EB363C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxC08-0003eR-NA; Mon, 02 Mar 2026 17:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxC04-0003eA-R4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:44:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxC03-000706-8H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:44:28 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622Iu5dF3864119
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 22:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZlcYVhgGZJ3X5LBGpZssoefzO503GiY47AlQH/aUdZk=; b=pcKsrGvZqtS3Jn9y
 xcEs2+hjOVHis0xJN08sKonoJ1gV4cgpo17TgxVnYJah55hBRgac69UQgrgOH07y
 Hw5LlmAHWmYmJ1uy8v3GPaMUdPLxxbDyHFCVBnb1rSYjiM4yESAmA9cNrc92UsZp
 ttvLDxynH8O54m/t8kOPNmSPy5106oyOEE3A8oCGq58s1NMjSmcx2n03Y4PvpLaO
 q8xu/FLa4DwDEc0ytRkm70S9yE5dmrks/EFvLg4ThHe/zNCqlex+ySKz+H2BXc6G
 fB09z3HW31858p692IRhCPJUMwLLdVEOywk4lgXCBwgUbktSetnpWnRPn2huf3MM
 GeNatg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn9bjj7aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 22:44:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be191ce356so1262865eec.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772491464; x=1773096264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZlcYVhgGZJ3X5LBGpZssoefzO503GiY47AlQH/aUdZk=;
 b=IKtk00Ij20nN4eBXSlu3oo279ygvCB3fqxqqUh9PMcLqH0RF96T3eahX9fTTik9wjZ
 Rvot6N4hITVg+jImn+maQ/CvxXwd0pqO2YKRRo+/VDkm3yEpEL0Px9bAZqa/X4bJrFuO
 4rCQoVPToHjdoGYBD8c5/DE2iEDG6jYGDINm+IuiMTKGqHAdNUkEJMe82J9v14vUTa26
 QXAytYMi0y0d1tEmEUYG9jdflIQk6E1BsJyib3xwz84vRoOMUBbKMWM00IhETmQzauKr
 6KFpqZzIttLO7LSCyPClD+uyCfH1oR82XyNdYHrHe+ZNByf8lqcr/dl1jkTKpYP+86W6
 4KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772491464; x=1773096264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlcYVhgGZJ3X5LBGpZssoefzO503GiY47AlQH/aUdZk=;
 b=PsW+uK6FV/GKSK8Xq+dQcUARwU/4PP4Asr/c59A5MTDeSgRl7GfsnX566qYvGlHTVn
 Hl/WeAJxtBOcD4asthoIB1vb34eZ+B4/wveTVRcYpEyL/dgEGwiQ7kJZwuh8ryEs3oZm
 k5AozwgqkLZjCIMRhI6T+x1tmjeSnN8rSgqtOUmnnafrdym5UQay6D4Fafq1rlQAEJHA
 DUylU8729auGqAVVJBOcFvhF72XHHegj2Hhp5pjP5BVpImUZWj6n/bnbr0d1zxusdPfZ
 sI9i/oOQKOH3uZxgURSu/wdsX0t8JHl4UoYCZnRUK0BMne+cnLXd2W7/EPB2wGeHZZe3
 7Ewg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/KkSs/aOl9G6YfqTll40y/HqHoWK3cM+r+JBStnI3K0SUje/gV3nxwSZnC+OMElaYCY0BEdz3InsC@nongnu.org
X-Gm-Message-State: AOJu0YxUvxmPoaP0w49hQcWU/0ze9IBNzGbcFmgt73sSQ8Xo3QGG2lfc
 OkJuMhaSXh4OFnZnbEqsjo203PGbpRxvh++2wGPZ0jCf9v6iBoCyZ4R9hDbeDl8120zVWbwwjDF
 MgcFBvyFGlYYbQVbV2idS5HMyNnh9OLZNBORPv28aeyUf8QWIznrSj9+YOh0Fj4eiQw==
X-Gm-Gg: ATEYQzxsmgJipTCnyrId5ovDtYUT/eSE6AAUquvqgjmRvsQgiEp8GjWMpr3c4tDo/Ef
 n6/dfTJLBxPK8UM65EGNSbI06YEcqLF5ZqpXbFh5sS6Rv6Ys4+/y8G/WjCnIfk3dde7juKV7ZpR
 xjy0aPfMt3awhfFB29M7cpPZwVD2kkT76m8+YAskSAkEC/vcN83txs6+WITF6P9O/lF1ypC843o
 k8E+L39ofdwSmyJARagkVSJ5Nc3ElABri5FdDqT5Hx1Y02EHk3mTm6k+SrsQjzIbvSySLHDsV+g
 091xiK1a7kykr5MzGBXegD3toD1gELCmxgPtTycNvLX1EfP3x4OxMBwfxbDkjTkBrIOoQH34SD9
 nqZO77ke3+0yiINneEvSaEcqe6J0wTOAKEtnX0HtjCznwRK4B/1HR4nrqOFms00KdBcrVFO53y8
 4L
X-Received: by 2002:a05:7300:a584:b0:2ba:6d87:cf68 with SMTP id
 5a478bee46e88-2bde1c177e3mr4494425eec.16.1772491464111; 
 Mon, 02 Mar 2026 14:44:24 -0800 (PST)
X-Received: by 2002:a05:7300:a584:b0:2ba:6d87:cf68 with SMTP id
 5a478bee46e88-2bde1c177e3mr4494413eec.16.1772491463516; 
 Mon, 02 Mar 2026 14:44:23 -0800 (PST)
Received: from [10.110.0.81] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be002ee839sm7208740eec.8.2026.03.02.14.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 14:44:23 -0800 (PST)
Message-ID: <ed5dfa57-5a10-406a-b227-6c7d8cbb4f30@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:44:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] hw/i3c/core: Initialize num_sent in i3c_send_byte()
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
 <20260302032626.1974743-4-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260302032626.1974743-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pe7yRyhd c=1 sm=1 tr=0 ts=69a612c9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=tlE2hPHuW8ewRHtb1-0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: JjHbGSpFxGjmHRbEfn0vMGYXqVPfMlU3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NyBTYWx0ZWRfX+N+HdU+g+dR+
 W5v/OnuRwsTJzxEBlDTFxhNNEFSd5mPpfquo2KW903CM1RKyot1uYXEQW4E9BDLq2Y/xadHPrhS
 tr+SedRWEEg4n75ITz8ED0oT3R/ijaI/csaCBZ6HAoWc7O/3dwpMQz0YO9NxwiqfBIsGWrWqtpk
 KuXQWcpM4rI77V3C5BTV8GWn4RgIlZiQpwayy7O4peDWuS0C0+GrcS5Op1vaa37VVkSqOwWwcYj
 qZw9DUK96xrl9Hc0CWib6as0Hw+Pb4w92RLq7umAc4GEZxHV6PDfos0FEPeSXQEJ/lcVpl+iYbo
 etuvyonML5HyxPoCFn4MJJfkX2SGX9bWLRAxMP0I7RplH28bc9sdHtG/lXupSG0kKLlvZiebcAv
 8bQ+d6s3P5SFjxjNwfwwzp1s/3S/6z3p5deSmQyFMDE5tJGVJMq4SyLDamkQLg6dfPad3pFSA1/
 cVyo98FN1/dFQ0r3INw==
X-Proofpoint-GUID: JjHbGSpFxGjmHRbEfn0vMGYXqVPfMlU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020167
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> i3c_send_byte() declared num_sent without initializing it before
> passing its address to i3c_send().
> 
> Although i3c_send_byte() itself ignores num_sent after the call,
> i3c_send() forwards it to trace_i3c_send(). If the target send
> callback does not set *num_sent, the trace may print an
> uninitialized value, leading to misleading or garbage output.
> 
> Example concern from review:
>   trace_i3c_send(*num_sent, num_to_send, ret == 0);
> 
> If *num_sent is not written by the callback, this trace can report
> an incorrect number of transmitted bytes.
> 
> Initialize num_sent to 0 to ensure deterministic and predictable
> trace output, even if the callback fails to update it.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/i3c/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i3c/core.c b/hw/i3c/core.c
> index 0a266e00a2..168526003d 100644
> --- a/hw/i3c/core.c
> +++ b/hw/i3c/core.c
> @@ -325,7 +325,7 @@ int i3c_send_byte(I3CBus *bus, uint8_t data)
>       * Ignored, the caller can determine how many were sent based on if this was
>       * ACKed/NACKed.
>       */
> -    uint32_t num_sent;
> +    uint32_t num_sent = 0;
>      return i3c_send(bus, &data, 1, &num_sent);
>  }
>  

Looks good to me

Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>


Thanks
Jithu



