Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C491C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EA5-00074l-Cj; Mon, 14 Sep 2026 17:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6EA3-0006vX-BB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:24:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6EA1-0004Lo-Sb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:24:23 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYgCk844359
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 37rFPQFHCOPo8iPlrm1dV/gTNF2TLMhC6MlPw/Rkejg=; b=k4M5+Exxf16XS6+S
 vBOZyrPRKJgViNixj5LgI/auyJhTPOLtaQcxsnYcwlDcerM5+eeRZz+TTTuca8dJ
 ZJq7+gs1yWZ8xT87f4L7F4ChnnvZeBYybW0GFXoV5j3DxW/3Nsn/8ySz68FBilUb
 aqhwZYh1xu6WAfUUD1dAyUNxjN6i5reEl6uWTXu97NV3pKWej0iFkl2cTiG/4lPX
 KQGg1bOAjv5VB5DBZJ5iDxSRG7IgCW0fUqX+7BeOawsS19Ob/4UCSSCRzVO+4reI
 BkIWf9KZKmAx7jES5Nz/kwiopA7rQHbUC2PlBMYI7X9/TyPj0SlwPcu1SVKEmNOd
 A5Fl7w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f34tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:24:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso220878a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789421059; x=1790025859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=37rFPQFHCOPo8iPlrm1dV/gTNF2TLMhC6MlPw/Rkejg=;
 b=Szclbe79I6sPbdVjoeIGW3zgVLD774ed78YSUV6FZ/jjpyAj3NBs6JqjK7Nd0+YZnh
 NH0ctg0UgNhJFu9PDGVQxrtej2Dn8ozQisrEkz3KrryM4rcHlji211UggsnCskSwt3I5
 OjAjCRnwdq/2TIraIRZeuRYpixExsyr1WaF3Cudjfh5Tj70tw8qLWrRQ5WPHW9Rm1Fjh
 ekATiqRQKZTcaSgFl7aCw3HiID5nv305e2pR3EZXAtemgUOYFAYOONry5X6GfZRrqbHc
 FuLImWVLkage2CNthJhTQiyePYCRa4QWXNtHenIUHJr3FO+EdIuz701GIzYuOoxVEkmJ
 baRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789421059; x=1790025859;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=37rFPQFHCOPo8iPlrm1dV/gTNF2TLMhC6MlPw/Rkejg=;
 b=QblQ4hmkL59PKO8FcfWaX6PHkAClT3XoI54YVptO6gSDkRRjBCkE+8UV04tDAnxed/
 AhynogmDrZhR67A9yCBvxsN1DIqKPfKvJ7zvt8deaKXPm/ks+2Zk/oI9pbdil0ziVoKF
 iRZJ8B/eiJAAiwbhPLfX1S2Up0qXZ4KlPhdS0MVmyHVBGgwj6NPwcxyBXDwW8RBmzvkK
 ox4Etp48ACE8gl031gO7N5pZdDN5ExQcjR//zkE+fU+sk+vnhKU5T0OenNUkrX/uPAyN
 6P2yCHlCJ5Vl9y+wC7iB87hPF5E5EMQUXta8HbiIvouBGAKHUNcgny1uXWamnBBB5ngM
 HwJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwONrpO1B/gQmRC7lV/hA5Tqb3oRCEMNutGiUi1GiqtaBZRDtJeC/073FWpmMgIb/3kJ1OvD4qx/Drt@nongnu.org
X-Gm-Message-State: AFuF++k5AsEDiZxK90wbQsvqcy9W8I8aWcYrczEnItFqj8ivhwm1v6EJ
 FyGegLCxomfw1clMXnfXDmZ+0i0z1DQ9AH+4wcOAWHM0ADrntzqJVMHRv3lpiowzihpUkVES4fp
 zm9AErJlB9ilAbsXJJociIMKiFweiMEVgdl+aXwY7Osk+5+RDKZPizl3UHA==
X-Gm-Gg: AYBFou2CVDc6u3VYWVatK2Ua3CQjPnJXjgQBOgWhEqvnIMfKxI5PyU4JEhXmBn9O1g1
 1DOVxEAqD6KrDWZXAgq/nw/CjX+5Uvsi7gytrbkVDgxndW9FK7pVgsaMDCcdpasKBwLejJeJl6w
 AvMEHmkde6p5mr16wza+KvQ8LDIdSl7cvmpckQxtjC6oAzDGFrSMkdG8UD9t2biPbvXuPm4KoWC
 KvgkoDtQV1kGEKpj3VKQ112hk7MBfQJ1OVtsK1GmPyHYSho3IW58NhvfWZxDYLk5CdfDaOAeQk0
 c0XErUqv824CmSNVWjaDFWRKSFtoAl2IFoQeEgH/g3HIxCgK67F9AvPkkojtWA/PMKu3yriEL4V
 DgoAQaJSSfxVT2EsBqEe9yDRHRL+1kWrn65geVJxP6ZY/8Ag/OEsyOuoanruDe6Usse/V
X-Received: by 2002:a05:6a21:a347:b0:3da:11e2:b36c with SMTP id
 adf61e73a8af0-3db501d3b6amr1468023637.27.1789421059188; 
 Mon, 14 Sep 2026 14:24:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:a347:b0:3da:11e2:b36c with SMTP id
 adf61e73a8af0-3db501d3b6amr1467993637.27.1789421058814; 
 Mon, 14 Sep 2026 14:24:18 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm25361233eec.30.2026.09.14.14.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:24:18 -0700 (PDT)
Message-ID: <752ca8fa-d26b-4054-b027-ce95d9950a8a@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:24:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] tests/tcg/hexagon: add scalar+HVX and masked store
 tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-17-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-17-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3KiIhbr_G1TeXRY-LM09zf9rD_mBXJWc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNiBTYWx0ZWRfX9ds9o4sZ5lV9
 vgsXjp8NF09HpapBdMXd37q56p+ZoHUlUQhc4ydeTjRL5hcnKBa05TCicrspNggfIixB4hPiJzj
 +DWYaRE8hQrxw9ES2h8YDWEP5AlJNbQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNiBTYWx0ZWRfX8Rg7CNcZsYBT
 5/hNfzw3InCLFJMzLldcN4/lOlyknSchyjkjdN7VxtEd+uAi4NnIIiQo1S8piyuqlTYN00GqRM6
 L/TotLmbV0E0ZrshYjYwlIToOnxD93V8LvijJ2PFmFkZoBaaYjnpmoWehwN4HYasHKxMLy1WKAT
 +OItewQoy8b38gwTJMn7xRItgN4JlAmcHNpXEK3RjDIqEo58dtAVGJchKhcjVQS6K8YqjeCAsvG
 ai44f88Qt2pteqkdVNWCMRa9Jndwd+3zuv3L+iGU9LaVqMvCM87JACUXMqQ/LBGzbSO9iMfU/aI
 yT3BTdhGNPSt0pXGlqbmj77ElSXjqwSHh+HRBtZdRCEbUoYoW6v6ydyPXilu2Igt1yhGnWT458I
 V//1Wn/u6D52jOGJa7VvcYumJIVXaONm23obrjtw7l5+TKH7sjBDIP+Q71MNLdYIbsoPv060lWq
 BzejwX9JTRRO5mPm52Q==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa86604 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-YVKXp2DU8w1PCDTsR0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 3KiIhbr_G1TeXRY-LM09zf9rD_mBXJWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140306
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Test a packet with both a scalar store and an HVX store, and test
> a non-inverted masked store (if (q0) vmem) to verify the invert=false
> path in masked store generation.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hvx_misc.c | 66 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

