Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54780C4453E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmmme-0005Gj-Tg; Thu, 23 Jul 2026 02:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmmb-0005Ft-L8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:19:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmma-0007Nu-5g
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:19:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6Ak933144957
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3c7EHBSWRswyKs55mJJeHkxZAImKw5U/DimYRNDLPBg=; b=jrFtxJXjIvLOhtlw
 IpJxVou7LHDQvRl53ZguX9QZtaMSfWnUbsQaTiy2eobfye2gyHzMSRVVUFIacDKK
 lwwm0PYVTe+I5+eZu+ZrDb48mBxtPmqNzmMnxchUKHyZkmuRg8IqD/TXPRkgYYFZ
 K6QS5tWYcnnk+8v/x1JIZrKKF6JiMFH122NM9tO3lcLVtMXwz06+ZJOK4dnHuyJm
 VvZ4vnmTnhmmVyT4Yn4TlyxOkaV8+t0szV27r40A+gy4xub9thDyf3nBVUwyUVjZ
 eIPH+JaaWoFrb0jczt/0c9qiZoVxojlb5PXqsF0Y9VDcTSrlCvQRLfQPFWPiVXQd
 SaSJjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm13q18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:19:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so9122811cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784787586; x=1785392386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3c7EHBSWRswyKs55mJJeHkxZAImKw5U/DimYRNDLPBg=;
 b=cVEkn6E2PrlTGfqLpX2oEiRAezS5tciY5zDItWrkj9rh1vsFXmDXf+SnANsf8vCgEb
 o0BhstBldMqXuT5K22uRWQSTxy/6Su8olGrWmudQC3PYcZykeqZwqJBuVbaHrJw2c94F
 n0SPqDpYBnWl5v2wDOtWKLWpfpWd8Rn1eHCqK3Y5SeTELmrJjZkq0URQH/ZU8WEWJcJj
 Lx3h0clIN2yaU86rRj+m/U8Q63BuJITeLavaKEQNM1UqCOe4zn+XQQbWnDN9mT7H0Iwx
 vcWWSM3/dOH6HcRZrc1w5TDwsM4N5bqYUcY60fDDjBUnQqYytbCL2DO2g4p9YozyPYE2
 fjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784787586; x=1785392386;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3c7EHBSWRswyKs55mJJeHkxZAImKw5U/DimYRNDLPBg=;
 b=cJPjIqBoZ+oT7Q9OTBg3qT9fuK9LvFbL6qyVw71I9kupF4Nm5HJWvP5g1bJ0p7kK1c
 /Su5Fy9YePyr+KoyjZeovM+bRtkBOrSaHyso85JIJb+breerJYjEgLo+0Q7X5bQD+aa2
 ivDXjhiSUQhz/ic+2s+kUWhzb8p8yG+c7aXjbriyQLoWlpOtI35F2O5T7NyntichC8zD
 GyT26Htn3dniBMUNAn6IaWLcaG6jgnRRTilSOfnbgCWaH1Qx7Xjp28fAkqc1RUCMqHQN
 7U7j2VF3GTSGwBadM0IcJ32Xo4CamcCPoF69YJ4i0ehGkOUwJGwdcfsz1p8r8MCpiSW9
 zw+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrs24PysCmllCkK7QzVXYvnodZazrM+5WyjClrKg333Qjg+dfnBM2HEKCTUAbdUl+xT7oTFIvxoI4aM@nongnu.org
X-Gm-Message-State: AOJu0Yzd4+Fo66gooCVulOCHEOX+xcLFhckT5kJeZQFkTph/Bz8IU+Uv
 5NLU1tx/8+LkUXbP6+D2bedpH04+4ur1F9e2JhkyJ4WDHWVqygOnqR532DzeMRm0/cRp+KxPMZ1
 58P/S54ynQ0heW/U7PzZ4ckcd02jqKOag4jFS5Wh6DR1fCny/FsFEoSXk0A==
X-Gm-Gg: AR+sD12/ylRM3T5tA+2UW+hhh/wkZBPkWQpE07oMGDn6eo6uZz30amccO+OD2/nZyk+
 HQiyD76sQWqe+E3ii2vW3GeXq3ETAK5BeaXspPWnsJtD39rBEkhcqqmSLpCwd0ksGN762gVMOT5
 v5xJv4ic1lV2raZIqJP86jIt3jUmWVB2kszh1Z+Rq962f3nocQLV4PqVdcRfP2gQxBl37UTByy+
 rFYSQaCQVCh38JcyvMzMCJsE4T6hnz0KaTZslxLYi8ChycT+V0Aq+gZB72/D8MqkkfN3dL2aHML
 5WR17w4mC7Yyg8FCcKQY9S6cOlNABxcRNTJCkKQzEyRRnAV0zObYSXFzfQL5Ak1BDyxDmQwu5CY
 6QUWt2Bo3DO2SwyFqvVEuOWMtShUch35Scnm4HH6DCzOd/HtQCe4=
X-Received: by 2002:a05:622a:1308:b0:51c:1ecf:436 with SMTP id
 d75a77b69052e-5283df44933mr15989881cf.59.1784787585745; 
 Wed, 22 Jul 2026 23:19:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1308:b0:51c:1ecf:436 with SMTP id
 d75a77b69052e-5283df44933mr15989771cf.59.1784787585291; 
 Wed, 22 Jul 2026 23:19:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm182169625e9.13.2026.07.22.23.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 23:19:44 -0700 (PDT)
Message-ID: <0a2819eb-617a-4d42-9e46-15eec7fcae18@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/xilinx_axienet: Don't write checksums off end of
 packet
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowangio@gmail.com>
References: <20260706162704.787495-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706162704.787495-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2MiBTYWx0ZWRfX78EE9NdaGU5w
 zVDAzxtlRMt5AfuF0ljJopy5L5lP20tzMl98URaiXgJR+z8HdlX+MhgaSlvuWb+vrrxXjCcUxjV
 tEM5IbTyyvKmHgqqMu0QQGqjytbXPRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2MiBTYWx0ZWRfX/gNKE5WVyARi
 u3AgmD7c/G+cR2v5govjoMecvQxROxNR/G9SsCbRr9p0rRHO6eU8JH1IQtCxuLcgaE//ngZ2zsq
 8a5MDIoFZcMwnCObtqkvb7ImZ2gIRfU8RE4tWg8SRYSzUq6KRZEaPaoa7hW2EIam2f48WosBHwm
 2j0onSQ5K25jeYnan4Lu/bXAoNvECSAQ+5TctMLU5f3hV8iqkCUdP6MGTjJk6UupTSTpoR5ghPf
 y7OZKfgJeXoGuVHumYfDecTJDsqhACwslYWJS742TVGG4Ni9VpRODWoHO0gItS7JsgfbjLLure3
 c5hOER0ONRTj1sl5AWWU9u6ONXObyI8Asl76v3nZi3dK7zXlFKpPf+p1dVNln6ET7TFfnAyk7pJ
 3CDZ371AbvbWtn7302QvNLNUc28pPgIMAYsOTdm0F9qKgIyJstMPjMcJfT/9cVGQI0Xw80dC48/
 pWhXTiDOF9Vz2TSUnYw==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a61b282 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=srRtvreKeDvzOjGVjk4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SbRw7s5ZTW-AeOjq7L3iSo5ToXpvo_JK
X-Proofpoint-ORIG-GUID: SbRw7s5ZTW-AeOjq7L3iSo5ToXpvo_JK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230062
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

On 6/7/26 18:27, Peter Maydell wrote:
> The xilinx_axienet device has ethernet checksum offloading, with a
> mode where the guest provides the offsets within the packet where
> the data to be checksummed starts, and where the final checksum
> should be written into the packet.
> 
> We don't sanity check the TX_CSINSERT offset before writing the
> checksum data into it, which means the guest can pass us a value that
> is larger than the packet itself and cause us to write the checksum
> off the end of the buffer.  We also don't explicitly check the
> TX_CSBEGIN offset; this doesn't currently cause any problems because
> we will pass a negative length to net_checksum_add() which does
> nothing, but it's a potential trap for the future if the type
> used for the length gets changed to be unsigned.
> 
> Explicitly check the offsets.  The datasheet doesn't say what happens
> if the guest misprograms this, so we choose to log an error and send
> the packet as-is.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3599
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/xilinx_axienet.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

