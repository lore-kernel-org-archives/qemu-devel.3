Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29D7C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr9U-0001hu-1T; Fri, 31 Jul 2026 13:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr9S-0001d5-4p
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:36:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr9O-0006Z3-AF
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:36:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFO6eF070874
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gDTpx3QpSnvMCU6K0WfyYuuEXIw2fjqYRYdMaVHXNNM=; b=PFpVnfe115u/DMp3
 3C3Azg3PBa5KMdZLu6hdzdYPoyfyp3W7i4qNaFedRzeDkOxRsudCmFDYpaBozNPJ
 gHKuW8OhDMsNcaQHRq7FUii20oheev8rXkW3eoW+KkCcNS8xQWHcRK5hHs6DdGLM
 C74tABVzhRF2RK79G0d0cbqPIQeF31Mm5FIY6vnmkX7hmLlGDj/mTngAUEcMvxyb
 66Oz4f4E+ObqtSOflAixHI70M3h6clRQydEI7MP0Tnoiy3edubjaWN7jZtZZjgJa
 fnyD/7o+M8HNCB1pmt1E/aU+3r49O8HYoX5TxSgCjUwgl45VW00W5cTRxTK3zSgS
 UyU7oA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frtyqhnyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:36:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so2324752a91.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785519359; x=1786124159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gDTpx3QpSnvMCU6K0WfyYuuEXIw2fjqYRYdMaVHXNNM=;
 b=FGFejaHMlRwdPvWuU5NUWa7sa5uz4Dn4BWiieNGxkOlErwyVPbwcIyrpKSvmnqAiHW
 /BwmXtFS7jmhjlkk5hGOLTYjPFmRIImNZ7uebnAs2Un7OIOnKAksl1ru0tNCGPOG/c9S
 NPgKHY/Ckc5z1ABkdsEfvNTZ9pHmbi3bnb3PNVF9RMz4brWI8c8W/7uDYik0dCIKjt7p
 I9a1qtsgAArph2V5QbE39I3VLNFLRyuM312L6c6HNJlfnuQNJtk79S0+DOtbIqFucUWA
 /jWRaIILorBuHrFyx0jF27SQGsrRjkQf5Lr5ffjXXVpc4cgr47ZD7cH602ERK64tn/uj
 Qb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519359; x=1786124159;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gDTpx3QpSnvMCU6K0WfyYuuEXIw2fjqYRYdMaVHXNNM=;
 b=jSlLSUESJs0OkyZ7UWiYUvQngb8ewke3dgBydxEEd2K4SiepvGXa437RsuvS+h4Bar
 EM4YsU2p/PoEgLwxUh2orNfyCI+YOcTCgRvX/pUQ0IMiQW6h/dXxYoE4jfJp5x8kpbMf
 EgOZG0ilO4yWOVslIZcLB498+bngUj5gZ2i2AKBfwBH3IOqES3B4U/4uTDMeNC9djFmK
 KaPAthwwaP2A+TjUM+Lm5f/gv7gD8v+JXPdndSIo5ajTX0jkqnANLxZWfWZQFLQempqg
 8n1Lng9o9AMuqW/vuDTKZVMybtJx5Lc3sqW2dRJY1Y/jOxWsC1khev7WcVX/tieavuZW
 IiWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDGrXmZWBSBMGNpn8wODay5K/7BYuvQ3po2vIsTT35ZDq3CiR0nWAGtNjUNQMD9yIZZ7uC0DT8r0r+@nongnu.org
X-Gm-Message-State: AOJu0YyVYzVeQz/pol2+ysXQn32g+4Px7bv/Ryf9u0gzGKiYp6rSUiBZ
 ODEUzdVgUaOKgTFBkyxHLseyfsQmZO4phMo2g7UtWhE4QUH3d1yb+MemeU/xNJKUOep1m+sJA8n
 5hWxdauE6xSWa+gWpk3xF1rBs6EsU+8Wtd8Gkzi00At4A1qVxYkszNfmqaQ==
X-Gm-Gg: AR+sD12AZmmxOOusWrFAkTQ7x70AfG9EW8ozzgZCTJqpO8gjwVzEhe3WpMTQVDDXhbf
 0tS5uKZUXicgn9dCIsosTGiid5o4a6QpDMs57oD2XSeMCfR5BBQ9I+t4yQIoo3/ZGRLaTe5JM3E
 2lvlSt6bFrzwX8ave/bLN/SRrXQxQhAUF3L56wTxKvAUP5TAYGR+KsiYSDx+b5Sz0oxpKjNPLo/
 iJ6xIcQvWRFY7bGe2UUFfSy4A9z0iIeHrNubgf9u65KsWX6WyfJ4u60r2OPcIvY5PujGuVItM8p
 3dB5k1Bbkkxs6UT38TuIM8EWOoM1vXuaH553JI2tSInU9eGK8aUqoLbjNxkuIwGXUMQBsoil3y3
 Jm60U+mSPcs24XIE8NwEjX8siWrKhpJMDPVCdqiNgOsPUPT7R0zoz9o2qYG6zOQfTvE1n
X-Received: by 2002:a05:6a21:112:b0:3c3:92ba:c61f with SMTP id
 adf61e73a8af0-3c92a5176cbmr713656637.8.1785519359321; 
 Fri, 31 Jul 2026 10:35:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:112:b0:3c3:92ba:c61f with SMTP id
 adf61e73a8af0-3c92a5176cbmr713636637.8.1785519358865; 
 Fri, 31 Jul 2026 10:35:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe396eb7e2sm874228a12.18.2026.07.31.10.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:35:58 -0700 (PDT)
Message-ID: <e852b202-70c3-478f-b7d3-a500e19b86e3@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:35:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/18] hw/hexagon/virt: add l2vic interrupt-controller
 and virtio-mmio FDT nodes
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-12-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-12-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX0r16XBotwPyJ
 2nFe1oQ6m40hqRPyerG/YcO+wIld7nV+7Nhs9XGgENVjvzL5hHdB+/Dl3R22laLDo1/Yct6LsZP
 0ZACgF0qeCoF2Ntxs/BGueRtxm/+qbdpFf8jBoIQX7PmVIrcHOmFOrS23f5BNNSuXkv52xCGYrO
 5Efk6MPYTTBu1YujngL0E/5yaG+PTSzqBLQW+eGKsw7f9fOLs8M29erWjTWCnxrP9kouvuIaidi
 UPsye9pL+KkXUhaH77IqhOOs8LKA7rLLHP9rBpm69Mnt8j5u2PF0SU4y6LKVkUVnWZrn2nRLPcu
 OfwcxyzvsMlDOAIeDCZ0CInAmH8EgNW546NhaczaAJnyOZyw3IebE+EKPKHuQqwOYiXm0laMUa2
 Phl9lEzLHhitDUD7DgVdPbIRcnMcEYwHr0UsrYCi7OrODycbH9DLfJUG1fIiGqFBeZ59Zy/4jHP
 4vSgyFu53U9e7z6dgGg==
X-Proofpoint-ORIG-GUID: FfiKdtpCDtwmdF_etdbU-drEtgvsUWTn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX1FPRTOpAuA/M
 tRfXQ5r1O/G/2oWnnMXiuwNaMfRNRaWuzuZG+XXYz+xMtMdTRy+g4lwL0Sb6liQqiuXg1DOYlF5
 jqasZz7tJixCwcwpknCrS6HZWzznLoM=
X-Authority-Analysis: v=2.4 cv=YaGNIQRf c=1 sm=1 tr=0 ts=6a6cdd00 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=vkEbQUiz6cOOwxWKWR0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: FfiKdtpCDtwmdF_etdbU-drEtgvsUWTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> Expose l2vic as a device-tree interrupt-controller node and reference
> it via interrupt-parent, so guest kernels can discover the virtio-mmio
> transports.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/virt.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

