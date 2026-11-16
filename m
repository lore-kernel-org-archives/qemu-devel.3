Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7F606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bqyU2fCK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WzynhWds
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3jG-0002yk-SZ; Mon, 16 Nov 2026 15:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3jD-0002pk-SS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:55:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3jB-000346-R9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:55:03 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfM9E2042011
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yaAvyU94n9hgcr00HmAzN0TNijNbtY4Dz9cHv0ayrHg=; b=bqyU2fCKUii+itmE
 LtlZgnxQ3RFpWG2eRixokXsZwV+/sCDNxphUEr7kYVzidaPlQZ43CxHb6sR71FpA
 ukABt5exsfPg9o37cYCEb0wT/zaOgqDW666qe4jchnryNljYNBU9d6FDPGt/aymI
 tSnSxy0L1QmQvcnnc+uyKa/oTtdtWYMCMJxGuECs374Czrr5ta5TSFNxYG5bffLW
 cqAwxK6daoU9ErJAYfdJLoZeywrMIGj0I9Es5WvwBWpXB5LABFF8dheGsqfF24jj
 umZdCKPYGfbtlhf32o/lUxeN0LlJTBa81e14Bz/CGKl6Wa5omcUpYkzFEPhNaUMJ
 05WWQA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j000g2fm6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:55:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5602597eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862500; x=1795467300; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yaAvyU94n9hgcr00HmAzN0TNijNbtY4Dz9cHv0ayrHg=;
 b=WzynhWdsxSlCMhEhUAMPZncOz1HfoO+HpRhdiJb1M9EJg6Hyr4sNhEyXTCZONtRQ0G
 0/BCf0fhcG0zMPR2p98+uEkciybFmkdbH8AxBm9ZJpFM6WCko0ijqr71Akp/ZO0wn8v/
 xYAIAeq9KdutMD5o7qjs8Qwpc1S/8mc3RPa7Fiyy/E/Qr738cASHo47G9MGLrizCNaUi
 kDvQFcG/TXnEcMK5S/Z0h1gFBE2ebD1uKh+Ze77PUxRSlj7uClQg69pELVDTBxVGYgVl
 Kdw7Utx+VzE60fyT4uiZL5CxS+HNItGrhiBEogX8RIZ+aGf5Br6v4dF6ggvBiIHgE0Hd
 Yy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862500; x=1795467300;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yaAvyU94n9hgcr00HmAzN0TNijNbtY4Dz9cHv0ayrHg=;
 b=ZgTgUBP6La5liNWk01h7+Ago7DIAQYI26bC8M5H2DEkmqoxVddRMDCmal85shNbD1O
 1zvpexCXK/PBeMLzRveAb650/TRyF6O3FXTPl1CbBYoz3jj7kIMMbbiYiUQLzwMSZVoO
 3WrrpTZcWSdSmW0s/6+aHnjeqo3cOhLHAOj3P3OwwS2yBv1Mmkr+RsK1RiG6l01mD3ci
 DR5nFlDIompoYCeWeu61F3DWtg5dRkyxrrYvhAg0vm+oQ4VydJpRQ2+n+eBF4Z3Nc4Lg
 qi7+Eo7xhhISFl2K7cNgrGhPWjJs09gO+SJ76nzp48sGqBo3nOnWnBWSFJCDNHgG9TfM
 07lQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH/GxdlUAVeM3jGaYwdXP4026Du4f5mC1L+Af4CUvhWWcFolvVpwAi5mloc0DJhVhngaoNKi8KxgtXe@nongnu.org
X-Gm-Message-State: APuU4Z8BfaL2MLHpbmib+BYdrY0g9qQ2e/2isuqsJ44l7nz1BtTFvs2d
 ghXZGV9HZPHiTxKEmot0GdUgo1TXsQQdmredPmY64ePsW7Lhji9zTx1imBUzwEwhxGuka4RZYrJ
 iogaQH9i7+kNtdV0YWuUM9mNisPMeujsF+lzTS7DvLnijS/6+SepRavghqw==
X-Gm-Gg: AZFdTZeznQKo+6zXYfXaA/LoFIpK9Txp08ziHBfChenGbCdrEFOqfHiexQLpxcLRJwI
 xVGw+I/b1UJnIasoWcuOzE1uO2Plp/7yUSy9zQc2qzCmKDYa32bnPmwzXltcOXSIixuDkFJgvI2
 DwAV1lOfSDmDKDsI2sH0A0MvONvsBVnybzCwimScPBJm05SG7eF95+hbhiypZe0YjoklkLO1+KS
 takQ6qj/tBnfyUeQsVqhrEKn6VzXjQZuCK4rIgx/xxYTBAX6EiPSDXVVuSN2aNdneSxDZnJthtQ
 l+oMSGmLoiOca62vzQtcwQeSicB1zUgxFyN4XKHPOkun3/ocsqiAajX89AR51kJ//zprfThkGNo
 bZ5378cztOHkoySVpttI1jCyxQ1vWmLdxg2yzs+pBxX1AwK9X5PqiILSQXxenG2hV5LZZd5NH+i
 vKtN3nbD0QFjFtucxI7kQ44STmtxiFS+4GaqKPMbS0UBA=
X-Received: by 2002:a05:693c:87d2:10b0:36e:53bc:467d with SMTP id
 5a478bee46e88-3796047ef7dmr10154940eec.0.1794862499557; 
 Mon, 16 Nov 2026 12:54:59 -0800 (PST)
X-Received: by 2002:a05:693c:87d2:10b0:36e:53bc:467d with SMTP id
 5a478bee46e88-3796047ef7dmr10154928eec.0.1794862498980; 
 Mon, 16 Nov 2026 12:54:58 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm55962557eec.8.2026.11.16.12.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:54:57 -0800 (PST)
Message-ID: <25a7ed26-31b8-4b87-9eb9-b281be4fbe87@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:54:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/48] system: increase space for machine name in
 '-machine help'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-10-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX4T1TpQrjXIBA
 pPp5cnMWoeZE+Lkb6eg+YCyK/qR8j7VpbifmWcBs5Kosx7OymRzVdToUW+QPaIY+oqkz4qBOHWb
 eR0IU6YGN2srmj7qa2Wd9ZXwUhgoNQ69Shgk3hFSp59plHG6hivtCJwnFLHBBZySqnZsPp/9+/g
 Rr23wX9CWeJsU4JH2sC87AYsYidNVXjgSHcRYIMrnzKLU/arkGS4ejt73w5CeXAeQyDbKnBtk4q
 ve+Itu01/Lq96pS3TIrJwi7F6QyjHcHxlX2K0vBmVY7wD+MUmP4S+pFzH0UsSv6Exg6eb2sTJLj
 AwvZv+HYgsq0dZWvcHkuQ3+MlXRnjkE+RSaYdN6/auyceAbyhuV/1msQO2Unj6jw4NY4oEgDZ2i
 B8Qi2TaohYCCkVe6gFHZnhomLp0p+IKi+h1JvtpRyETIk2b/tzvfbed+ykbK+oYscRkS8OLFcqi
 v/9+YrZkf4lo6tF0oVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfXztctzhTHkd44
 VKf9IIb5irJIBy3WcSvIiMAHNFALJlnIkRjFGlduTWda1qvf6MhWEDqaI5PAyeTbLhb/aJfbHIk
 y/W98EJn5YfH7ZgjaSC2I1WliRdh37U=
X-Proofpoint-GUID: h7xTECs4gRu2r-nUY4FndcT8ItnNG6-L
X-Proofpoint-ORIG-GUID: h7xTECs4gRu2r-nUY4FndcT8ItnNG6-L
X-Authority-Analysis: v=2.4 cv=Vdtir1p9 c=1 sm=1 tr=0 ts=6afb6da4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=iUOzX8xV4dSmssx0HOEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> The 20 character space allowed for machine names is quite tight
> and is about to be exceeded, so bump it up to 25 characters.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

