Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDA5C61CE3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXxb-0007k3-Qf; Mon, 24 Aug 2026 12:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXxY-0007jP-LV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:55:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXxA-0002oG-T2
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:55:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmeT2263521
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WF4YWRoDJBHeE0rmQ/0wqTKSFBEmoEW3Hm6ivVxEdtI=; b=DVtCrdWBy4X5b/8g
 U0VIJ8l/shvzPW66pWIs2o494sLoPHmOaV9CEFrRfqe6NbJVw8K9tie5rJH2Tu6h
 TQ/M/xXpZ0B/DruoPcrXBEIBmRA3CScNE9GN+8mhf1YxBdLL7/sSdxiJp2hGiZV0
 3VbjnH80H8eUxOsecn97JgN3g6FAv8wb+xF4sfQEj7f21c5z2hYTUlf13cg6Wzzl
 vDxcycszR0jrqQl5KElIhytn7Ko3MUM93mopQxCK6Yn0xJpskifUeOF6UNym/41c
 3BZBkNJgx5L5y5AetAgtcOfFtqcUNUJpj0LBKd2VYr0ISS3f8hIUCetHQF6MELbW
 N59Z1A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpkxqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:55:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc12e8e22b7so3800544a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787590515; x=1788195315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WF4YWRoDJBHeE0rmQ/0wqTKSFBEmoEW3Hm6ivVxEdtI=;
 b=aD+xLfOe4sQ24KoMXp9hZCiltOiMD8uepoGLq75KDgGvEMvnG/gMbgb3t8g9l/bJUv
 quNyS4pq6YrEvJWPHtxZMzlTY6eTII5QCAVgke58dyZszvgn4WBy8a/tb7Na8+ql/pfW
 k5PMMcdsxMrVg16yF1+9gpCyXjs6pXBKXRHVIVl4xTrPh417XlFw7ErNFiUX1SlWR03b
 YddnwUAAikrIxkBv78ixGDLs7vJgjkbvU4N+22pinQr+BMNNJXjtJKGJhSbfkP8gj1gy
 +oMs/kIdsaRcHYrMmIBASQiSs/b+pwCSbHRxJtmJ1HjIPJpQO2TpwlLEFa+oASoAoq2D
 rYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590515; x=1788195315;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WF4YWRoDJBHeE0rmQ/0wqTKSFBEmoEW3Hm6ivVxEdtI=;
 b=LctivK7GwCfXht5uAqrqB57Tx6TEPgGkyqDojzP5l8tQcOHy12Jt6fnBiG5EXRYCos
 OkAdLW2EYiPvJhE4MRcAXAsJ3qtmbw6dY02YhH5oedJvM1dEmnA2Be8RC4oabaAhxkvd
 TCRfpqHT26YAiELtcS316HcE7vYKWldCkYkXj8d6e4T1XDBHS7EZfvQ9Ev3eedDmgcEo
 ISC3xgovFOse2QgQHIUiq5WV1RfPCTyQz7l3HQOP0aLMtQaHsZV0R4G27G+Ki3pgDePr
 u3l1OSMVv4AIrTkrvNxero7ugZH6+6gCYRjmXdBPrlup8rrkVywtsY8cDw8BNR9I2X9X
 4ypA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIiv5TaKy4TtK/Nwbx86zvmwqQ7BRA5DVBU4LZvrXu45Skd723oNPTw7FeNmzAbq0UtW9TlIM1uYvc@nongnu.org
X-Gm-Message-State: AFuF++kfy2cgM5sXFkKYnnNos4FTUEuMsDG61aZMB42kd/Je6m2RkHoh
 xvyVZBn4HXUvxxrBcSapay9Z3GwS4ovGO3xinX2nvag3lljgpY+Nv2iVpYocWLE2gtwiPV1No/b
 Hxybqs7czUbUFXMWJctuaWi1+T68p80JcrJIy5sI6bXVpu0dupJOIkoD34Q==
X-Gm-Gg: AR+sD129a+ETUXumFB1tq6myh5FuPjeXDlVWnHBVpQkwDrDfgFC5qcmsdNoP0JBKrrS
 V0Na2PxKiGbVG1DlUW+9G9uuhyDQE5GCxt7ppl5TxrdO3VuoKKuME7uns1/0aIhvaZpnny3I8vP
 fT2Wg49BhsTUeHBSi1XqgwdCkKhyirsjEcWkyDbkP+batuhKdaOgaGrL7kEWksTFn3YyTsFDHvA
 czsdZ/ySC/czwhlMw+oqaM44HeAiixaFgcaxva/1NlYF7RFSSnSsQloJRwqWzGXljs8A1ueZoTg
 ha1OhzDSqUU3tpodxE27coR+2FgcbUJ1/faPMnAmr+i3EBOq7SjfYqZOKK+uaxBy4cYcu6lhQQ6
 Ny0QCJWe3xsSTd1XUfF0+wZWrgoycDT5PwqKXOc+zMsNkPSSveKTkiVWPIkrp6DdooSxo
X-Received: by 2002:a17:90b:3804:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-39646579b5cmr391658a91.16.1787590515000; 
 Mon, 24 Aug 2026 09:55:15 -0700 (PDT)
X-Received: by 2002:a17:90b:3804:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-39646579b5cmr391590a91.16.1787590514604; 
 Mon, 24 Aug 2026 09:55:14 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645bbf59csm210152a91.15.2026.08.24.09.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:55:14 -0700 (PDT)
Message-ID: <91f7f101-0d2d-480e-8935-6d5922dbe8e2@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:55:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/40] bsd-user: Move sys/uuid.h defines
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
 <20260818-misc-2026q2-v4-9-09bf5647c98e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818-misc-2026q2-v4-9-09bf5647c98e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0MiBTYWx0ZWRfX3mpHUxMn05z8
 d7wy/ScqkamC0or2KheP5KeHIB4Myyz/BvfNrgrgCBclu9cF13gb/onxZHfcfVOFhSNgTDFFpsa
 G+T3sgeVKCRRalRbuAM4sC8wCYjAh5wkUANWNgvs/dXAzo0TcfeRAjrHVvLcdCCXQp3T+wbY1R6
 qaFCaFZEeVlHbLP0+9B7ZTPoM2J9Y6jVSKOU5dSrU2JRskC2ipD92sy0OpXZgWq+aIRvcKxcVDy
 scjm0YFr2i3VwE/BJciOek9AiF2drOYXYcRQZtyHBVuMDqAfzppOvwlApk6e2jaAwLzVD2iQ5Z0
 Ij2YFwgO0nsjgz4a69o0f7pXd+ugDm7cLrfGofaruyThHEuarpXG7NY1qGdklDsJahaXlwBxxmU
 SJdnM4HYusBl7j1HnFX06alllyWr9RP1bD30wrqgPwyQUhzCTHAvuhUEL5IwZMf8x9uzvphrtgg
 fhRBgrTxM1ZvcGSbbKg==
X-Proofpoint-GUID: cnT2xPCqgCtxvh8NOi3X9UItIHbKI5lB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0MiBTYWx0ZWRfXz58/JA53wMKX
 Y/xebwxjis1njaPHmEMEVdR0zmZRMtw813NPWLM/d31oyXLtyiySTSOKoMWiHGfzhorcc0tSsp+
 sNU3qBjImTKOlew5vEM/92qVIglz0NI=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c7773 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=iDqJXDbzSKkp3wG63TgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: cnT2xPCqgCtxvh8NOi3X9UItIHbKI5lB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 8/18/2026 4:56 PM, Warner Losh wrote:
> Diff reduction to blitz. Move sys/uuid.h to the location in the blitz
> branch.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/syscall_defs.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


