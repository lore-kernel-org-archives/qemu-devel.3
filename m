Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA58606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hAHdZ816;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ADrdA9+l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xObsg-0000Gy-UV; Wed, 04 Nov 2026 09:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xObsf-0000Gn-JN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:22:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xObsd-0000qF-PW
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:22:25 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Ba4tX2310265
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 16Qs62JGckWWISnBxDEb/gXyxFUZhSgiOpbFsNQ3f2M=; b=hAHdZ8169JvDvepn
 uMyUm5nBvI+7q8glxvEPQbQqcIg5/85TJbiRuHRWPJRuQESk3CxSV2PeHv4gd6QN
 idJK1Wfe0EfNMZH7yLasuD8d5oxMWggYZKblmxN5qdLaxVBHqwhNsAJlilcj097C
 ZoNRkNKtnY0d9Kc+rhHY3qmshVylmc/531oSkhYBCWpJhfxjYbWAXVFpJ5VQP3aq
 vs3XhFBLzPTrckVTS6SVRHYt1sJVzd2yif0x4LTT+C1bpg2ARcSVoYXPhgAknOHb
 cSynVXgQqYXiW0kWI0L9R/BUdwgTYSbL1qoWoQZRqMZSb6g/VRME1fvCpIHMRPbF
 rgG8xw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8mv880-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:22:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb93c874bso369008885a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793802141; x=1794406941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=16Qs62JGckWWISnBxDEb/gXyxFUZhSgiOpbFsNQ3f2M=;
 b=ADrdA9+lllCi0EmqO+ZISsuXwWs1/7lFBBmnyE03oMB9Pdi/cMghuWCKKgRz3b35fz
 Tfw8+z8yAOVELP6CPQSEr08LIdB94R4J9hyrb87y724S+pVkTriMyCzsAlfWWU3sQLfV
 r7z732nFWIOfi7wcRCMUbfwMSBJAHvZJZ5ugJcHMWyv7GZSowP3NBySUQpHUrrxfeFlp
 WFN26z6cpMIMbzqYkNUBO/+EPV42WvJIdVvd2uermVB1TEiZC02WdJ9fmpnSLs4uGmOE
 4kovByc8ODeGFH+M1KNEVu5NwLmAiMyePrf9RL3B9nEUBUSNKNRSU1UOQLSwbh/XzvI8
 GQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802141; x=1794406941;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=16Qs62JGckWWISnBxDEb/gXyxFUZhSgiOpbFsNQ3f2M=;
 b=vFoTzk3z76F6PdPyxpV8m4rVqI2+4VGvIFdhClh5QebC5M1upIxgyC6DmdHAx1497K
 cAnc4/ag0RGIwzXb+tvyzDqMMivwU3cveqWRCo7hnmwwGtP6FBFKEe6fOhQwtxdjy1Gp
 fndHeC7iROWfcTxpV6CKUDfI1pXPqKUMoxofSfa+e2wHNGv8hLZ+q3XNFrZEztpt9XZb
 CYwAZZ0VMYUprKnYJ1TnAZVjCqaPB2OoAARkuGJpz9rtpZ1X/irjFar5YlqvqihlNRF2
 xnAAN/89/jNj/l0vtSAgOmYRg2Mj0n7BlLHqkWxwUrpSCqQmLb6EOmHAbDvC/0QPrmvb
 nj8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcKp1006Qfiqw8KqLljV47IiEklb4QR4EYrRCv7R8Os3lqCYUfCfqjZeoGqZzY4GML3OpzYCPrVJo/@nongnu.org
X-Gm-Message-State: APuU4Z/An3y1NextnP21DqP0Pkpj0NYHQRde+f8SNeyplbt97OVKhm6s
 TsiWCH/5mOFsEggH2/+VVIhcey+WhJk5I+H/abk7c/FzTcQ7IMcR1ysTZWBX5cTTfjL5AZcE1qJ
 Xl6nn8suJCIP/YYP/aChvtI6DvbQvPAFmQuUgwuTIhgQ7lJ/A0rNp6l2xOQ==
X-Gm-Gg: AYBFou0LKS00PGTdLYevKp8Fj3ji/JqvOhTbMyusJr1gweM1/ffLvPZpIuKhPFMf2LK
 igl8FtcpsxF7LQtmJPWJE1Qo9Hzt4fqNGvPEMgLn177DFNt9OtID4SXBdINuzPea3n7hN2jQRRg
 VRcYWD0qGk4pK+jNvKEpGj9ncZpznKqamV0R1g85yeu0TNzMhCnNxXXlOo1XUJ9DAZ5mYiXOgPo
 gD8LjD++n5gGF26dWgmD/X/YGKssEQ46wlYjNczaEMWFPpNgz4fh+pZp1fVpvoXBK3k7rdVNNxe
 CoNh1Kh4MecLuKQlEkbY+bSbDVbKdXZT9GxDQmYrQus6+2rLJO3Cnvatux40b2tc9HWm0EQfYnb
 5CuSqVZ11joQHkyxvk5QSh55SX1cfyk2xaCxi555gvFpiU2TwzqeNLPsItikhiC6nPdVZq7qthQ
 0bBMO7CA==
X-Received: by 2002:a05:620a:4052:b0:93c:290e:9e9c with SMTP id
 af79cd13be357-9441337e6c2mr3058015385a.16.1793802141012; 
 Wed, 04 Nov 2026 06:22:21 -0800 (PST)
X-Received: by 2002:a05:620a:4052:b0:93c:290e:9e9c with SMTP id
 af79cd13be357-9441337e6c2mr3058010485a.16.1793802140434; 
 Wed, 04 Nov 2026 06:22:20 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4320efc7csm25125015e9.2.2026.11.04.06.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 06:22:19 -0800 (PST)
Message-ID: <dbe5c7db-17b4-46da-a28d-f399025f3acc@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 15:22:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sd/ssi-sd: Handle immediate write start token after
 R1
Content-Language: en-US
To: Manuele Conti <conti.manuele@gmail.com>, qemu-devel@nongnu.org
References: <20261104111619.24479-1-conti.manuele@gmail.com>
 <20261104123605.37729-1-conti.manuele@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20261104123605.37729-1-conti.manuele@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wlPd5SUT-wNPW0psDDOHghKLvsUPQobN
X-Proofpoint-ORIG-GUID: wlPd5SUT-wNPW0psDDOHghKLvsUPQobN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NyBTYWx0ZWRfXxdaIs6k280pf
 b3YGHE8bWLNcYjxjlTrGrkO5CrLm4zp+T4QPNAoZawOO2gasdyhag7EdQab7F2VM2FxrkrYwzHj
 h0BIjC2L/PXzTOWTok1ViAyw8i//YMd0+fWKiMIzbX45MDHfKCY+y5tI1dt6u0e5UDOLb8RBOCk
 pzC4bA3X3PyaZtWB1xTSCC0oXP8HdbJRl0tVeo4SOYZjmIs2r4o1VFwvlzilVHscSlFil62tQfR
 LjPN6yARX0gXQPbGg4N3htVEkKpV5DfDUiLtE/WSd8SGExl8g1y+rslz3VpV+G104yc7OauO3GD
 6gr/ajg96lU0hLCLE8bS4onPCvl0SpCyvDXlTgZyQgSCN/A3mcnXSqb8PFBi8e0ZbpVCxltiijX
 NoyhIAP/QD6nSLfA+km9RV24cTiqYa75lDqx/SUknad844r22v2iAzyouLUMTJUGbilmV85XbTO
 p4HnslIXCJgJ3cA24ZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NyBTYWx0ZWRfXwd7V3tyUDZQo
 pbV9gHnFoIwcY/MsZR32nNOz9UALSHP3p8Zhoo9XJUQFd1lEfW0X2vFSPc92CaZHzUe0dLrEDS/
 oIXy6Auj0Sb9XroirZj1JwXXdzozPjE=
X-Authority-Analysis: v=2.4 cv=HbWB3SE8 c=1 sm=1 tr=0 ts=6aeb3f9d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=uTJmtPrUgotVveIf0usA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040057
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4/11/26 13:31, Manuele Conti wrote:
> When a write start token immediately follows the R1 response,
> the SPI SD controller may still be in SSI_SD_RESPONSE state
> and discard the token.
> 
> Recognize single-block and multi-block write start tokens
> when the SD card is ready to receive data, allowing the
> write operation to proceed without an additional dummy byte.
> 
> Signed-off-by: Manuele Conti <conti.manuele@gmail.com>

>   hw/sd/ssi-sd.c                        |   6 +
>   tests/qtest/ssi-sd-token-local-test.c | 165 ++++++++++++++++++++++++++
>   2 files changed, 171 insertions(+)
>   create mode 100644 tests/qtest/ssi-sd-token-local-test.c
> 
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index a3a9f0c7efd..13c87c49cfb 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -185,6 +185,12 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>               s->mode = SSI_SD_CMD;
>               return SSI_DUMMY;
>           }
> +        /* The next byte after R1 may already be the write start token. */
> +        if (sdbus_receive_ready(&s->sdbus) &&
> +            (val == SSI_TOKEN_SINGLE || val == SSI_TOKEN_MULTI_WRITE)) {
> +            s->mode = SSI_SD_DATA_WRITE;
> +            return SSI_DUMMY;

IIUC this does not check that the token type matches the command
(0xFC for CMD25, 0xFE for CMD24), and accepts a zero-gap 0xFC
right after a CMD25 data response. Is that deliberate? (I don't
think, but if so this should be mentioned in commit description).

> +        }
>           if (sdbus_data_ready(&s->sdbus)) {
>               DPRINTF("Data read\n");
>               s->mode = SSI_SD_DATA_START;

