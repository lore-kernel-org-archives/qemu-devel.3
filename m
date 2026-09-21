Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB69C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8iqg-0003kr-Sb; Mon, 21 Sep 2026 14:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8iqf-0003ki-Q6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 14:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8iqe-0004KN-Ap
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 14:34:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LG77xr351678
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 18:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ueN7KjUbiSc//2M5XKM/pcbv91QCJpWri3AAFycnncA=; b=N7OxhUvM7eNFXfJw
 I9QL0aehFMbz7iF4Xk0ZAlxwkrUUpb+WQoB6coHgvObDCC2R6jynPdsD6vSSWNzO
 xWWwpuK2Z5DYi9z6igXxFkKcbym7h0r6ke27lKWIld0VWuVXFURltZULRnzR64WO
 UfG/hf+qYfEFtVMICFxURLTIS5wM0c7Wxuj7Fl2UXq95Mfn7bViQxaz7EhoPVIsj
 PqUiMmJvVw253AwR7UnYqE7qEpFC8fc5ADcCpkADbJaUVnkA627DBQB5sCnkuOay
 CYbdGEDZAz+a8BqGdSYETcfzpI5y5fhYjNctVP9nlNf2Hesksh+LG3EfTxIq9Ail
 6oNHRA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu7tsgmsb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 18:34:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc52c1b829fso4334547a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790015677; x=1790620477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ueN7KjUbiSc//2M5XKM/pcbv91QCJpWri3AAFycnncA=;
 b=h6bOIU9uMvd5JJrEMN3hrOUo+jG4Hra2CyEj5at6ppzXrQA9R/aeOl5EUlzuS2VLvJ
 1hRPW23cD+k1/pMysOkvpouP0WvPH63+d0kw0081rtydgNghEm7ePnH8Y/Z7KRuTFmE3
 AZHJbZhiA/EtnYfp0kbcTtDE3MJyP5kZ22Efp8CZekMq6gx+7ssG3HJQP7mn1e6t8yCN
 NSTNRvcyDUKow06vCN06pvAjmR839tXzga4zGsX6is8fNFBFoGiGf/9YhXAy7CroFUI1
 xSDeiV19Ji4r15xUASni8GLYCkpqlmJ4yI7qWlRYhLjowE9uNOYpE71UAUPDUGxLSNsR
 54fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790015677; x=1790620477;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ueN7KjUbiSc//2M5XKM/pcbv91QCJpWri3AAFycnncA=;
 b=hCGvFUtZjmUE+GVlHlpVObIrMh86Rput29TEh3A1vgVzMehab/5XAlJr7hjZMzJ+ZJ
 fJeWa0Z4Ntbk8w8DJNY7xvhNHyBRw8VQwit2R5SgJQCApyaZg7HB2ZTpgBEftpA1TBNv
 uYkXBOC/3Difan39wPwUzuMaX1Kkulq/n5SM96yYYE/HmZ4MrfIqfoh35Q/NdSfT7FSO
 Rfs++0+gRlPE/zeru5MY6O2+HFd4uCZyjcD7JsNJtX33rRkiSYLgLOLFvpx+aPjX9ULb
 PGCUxaGA83EXs5fG6s2+U/vRvc29mxfGF6sd68DYZrsFBWPD9+kwdU3O61PPI6R+/3Sf
 l0KQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUuB1MmEYXa/9buSlD7UFUOkYyru7h19vgdtwHEHshpM8MVegR4CJaIa2gqk5MEE/6Yu3xdvjeAHzk@nongnu.org
X-Gm-Message-State: AFuF++mziYwsKUE6N5IxyVACoYp36pkZB7m7qBk0odiCv4o4fNZT3O5i
 nfPZUtjiyvmlIc9YZr3X3AH0k1ev1G4PdTeNK4NcTNwyqZNE/zoh5IFDqCoyynTI5yHwxPyIMub
 hRaZPS/0vixoSyFNKLcZI8/7IggXYAvSoJ2DtcFA+6tINAG0Vy7a6vDHRtg==
X-Gm-Gg: AYBFou20WujbXzaQuIrPp/tRf9dMuO6PnZEME0Xc8CrjW9RbF6qrIsanMxGinWlcA+c
 1ewDet5LxVopQmyes7ltfuQkPb5x/wGSnQhJVjmGXxBEOMrdfFwPzNRePA2rIj0I7eWuQBiLeLX
 6XWxUwNEnS3gQpUZUGGXFITZxxklTHR0ASU34NjY5Lz5em/sXZ5D8mUwKGwRJoYMcyn6DhdtCTQ
 TF7xZ6L6ctc3bSl3tx89HlJ0kqpfUqclRc2CJW6OR5oJg5mMNyHjTy2C64CaUfEYwESERt80Azl
 UcT0oVY5Zb0BcmR5wwoC2KAll3ObtkZzo0lU3CJpB4meXDMcpWK9IEmPP+x7ZMqf6fk1TtILNBk
 JbryvhUhQsCMujL40NYUIbRgunBZgzrDTGjrp8GAR2Pfqt0F64OrFU0Rb4moPT6inf+qr
X-Received: by 2002:a17:90b:3bc8:b0:39e:237c:50e0 with SMTP id
 98e67ed59e1d1-39e54c05010mr19924733a91.13.1790015677078; 
 Mon, 21 Sep 2026 11:34:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc8:b0:39e:237c:50e0 with SMTP id
 98e67ed59e1d1-39e54c05010mr19924722a91.13.1790015676715; 
 Mon, 21 Sep 2026 11:34:36 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144e16a7f71sm10003035c88.8.2026.09.21.11.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 11:34:36 -0700 (PDT)
Message-ID: <06110af7-6180-41df-8c7b-dcd7f016da7a@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:34:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] bsd-user: Implement exterrctl(2)
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-9-ebfa61049bd7@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-9-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zutH0v-dJPzeBW3XeFBbGGXDPe8OkFY8
X-Authority-Analysis: v=2.4 cv=aqgnmiZV c=1 sm=1 tr=0 ts=6ab178bd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=USmZSTYOT8ONihnzSUYA:9 a=QEXdDO2ut3YA:10
 a=uoHBvs8nGJYA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MSBTYWx0ZWRfX+64wn8D5fOIl
 BWCjZcFZ+OwmErVLQhgnZJ8D4FfcL/KN1c7kFkxelcPnVi+ZtJ/Q50tF/U95iY1eOeNSZwSqMGY
 S7gnZ1mrEL2dBYVNDl3b/f9neIQ3bxM=
X-Proofpoint-GUID: zutH0v-dJPzeBW3XeFBbGGXDPe8OkFY8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MSBTYWx0ZWRfXy2su7I0TfFvO
 6zsEuz+I1nedQUTL91H4vjOsrEE9+lcX6cVaPOU0VqBL440ha55tYJlxbihOvtbSXcFXhXX8cQc
 X5YuiCqbolKlCxhC1QYjf5686YpkHYI7roCda+JefZeINaA4o3b5y5NsThy7aTGhWsHz7sWKad9
 bWeezFRKua3GMzCvTtemur+R7bS0ybB2Q/pCOQadd4UpBs2GMjAqref4tXTjsjYjVWcwUJEfNm9
 ftxh44KWuV6YifFh8kNa5OCrGhawfpRduWrW5IqTcTd2XkerEA6YVQcWWCR/F4gSFob0TcU2zns
 6SifI4Rw53npqg7F7hS8n8fVznXgCZCkTxf6LpRT7dnIBP0SdOfsfIpBJXDcjt2lBl0ArAjMUjw
 bDJDiWby/dH43bFTohWfn/za4Vs40miVeqb6c/Bsj8GWA9IwA+lrD0xm0uJddLV+xXEhs8VCMY8
 0iHW2bTvy/XWx3V3nWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210271
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/19/2026 10:20 PM, Warner Losh wrote:
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-misc.h    | 16 ++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  6 ++++++
>  2 files changed, 22 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

