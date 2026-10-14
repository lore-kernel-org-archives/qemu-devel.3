Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85809C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5YJ-0007kt-Hy; Wed, 14 Oct 2026 16:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5YF-0007kd-OM
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:26:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5YE-0005oF-5j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:26:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZjCL3468940
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hv267U5mKA0I0VZweFQdnoDL5AC+b0KDwN1nNmK5CXI=; b=HHiLQ2kIp1BfBTeI
 R/7+DLiFVH9fCJQBSW/X8B3U/1l5Vvmyrk2rPcO9rPhSbu4GDTBIyXPgzVpdgHZK
 ICDahJKkaMkl7FwZl2THks12kXf2nx/ZvYnB5QcS/u827TlZCfVZRaiK8O1UeAzQ
 WSRxnvY9eMyjGLRfRBUYXtVtUUR0JkqAh1nnYJFE8WdQ9f/eKEECg/vURAu1NEns
 culZNkaDVcfsJ9nVtMQbUyRCiNRQ8BjAjUIi8LA/sISmY03oJIQ6IWminhsy5OL9
 SLIowF3EzEewPAeSgiuDwnbpPYZ6XPlEkrwkQqgi1lhkcnVvJYtCmg4TM4x5l2KG
 wufoKA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78utc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:26:12 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so17680746c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009572; x=1792614372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hv267U5mKA0I0VZweFQdnoDL5AC+b0KDwN1nNmK5CXI=;
 b=E4U3VB+TDgO4BzxHbCI7HU1TVvzA3be2c3LaDUX+4pQ5uXTg2npQhCX10aOCkZpHu0
 18wtSELOq4BocR3NbbvoVwNn4qBIUpkWqoisJtuFGuX8KHNVolTX3OOkrr080NEiMNu8
 dc/jim5v18UUYD2dy3G42/EGYWe8N37GWDdptZpiezG65jFk28/jRA1qMi4vzAwe8nzw
 jhRR1sh7zC4PM2vXsCNdQ8bnKWh/ifiddVePAKsN4aDl/IZNhPqqFrxMHgyG2f6AaONZ
 E70XvmmSRTJdkJzlmrviwkIZFSrDSvrcOzIzNyklUv6lCbfXj2+ikoQ2ua8oSDP63vtm
 2qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009572; x=1792614372;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hv267U5mKA0I0VZweFQdnoDL5AC+b0KDwN1nNmK5CXI=;
 b=GnOg2wPs5rRdpP4+v2K0UASeYM2iyeGXHhfTHugqtKwWCrw8idna6QVaEwSn6Mj97E
 63dCB+Zy6fAhm0kn007JEwcdukeLG7TiC7dJ78H8NXxeL3IELXUF5bhth5Nd5UDGSCTU
 tPSZNwEd4QR/yKuuIiNacS4ah+6CPoJ2YPkC+jmPdAirTXDVZA6Gp+Lzfgh5H04SSpW/
 W8ivdBzKuUSQQxhTHgaXEFEijFLDT2NAsjL3M59lES/nak6lvX50R7kkw89bkKN2auzv
 eoO/+upkdW/0aPYT+qORFSuGF/wFo0KlUEeHkRYOOg5JH7lYoz8XIdm+wWL8PneoEMdG
 w2iA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfk12SU6iFjLcdga1xha3NzEL02zYViPw0TiaElOGsmsh98bE7HJj4zpAWk3Bl+/9z99yYoZ6lf71e@nongnu.org
X-Gm-Message-State: AFq9FYIh7t5v5aRW7Xq23XQNNFeqn521y3uoOd2YZ6zKvrujiqWzOpKp
 XNEuXPU2ahmpoqKfD2oGDqKHYpgh8ntL4na+xLM/nNdoCLogTNDTn0af/2PTw0xZsc30IcrU3HI
 bG/7OkxfC5UWEFeMarpGdFCpsDMzGtSvi/SmUgFPWSkKy3m87G8QVfTe/Ig==
X-Gm-Gg: AYBFou24BfEm9kvYF8BgnqDZF5p6l+/Dn+BvmA7nplq0uQN1UD5HuzUrKCco5zMxrxN
 m//3/3GKZNcAWgyvZREW/iLWhb+qs2jeDO3ilUN67Fld7ylkCtixtq07YBRP3NstlH/6LcbKagr
 pWhit5/D18nLO7tMMK4mJdvQwz7RTRCZq5SzwarLR+Abb1mi/t/kpJwaIdVliucEnqO4NOJwST4
 BpnjqdS8aG7Ou19Pb61ThAH2IXX1kzoW3X67Iqi/cqMirGADLugPYx1jN//jvTF4cVxToGQ2O0O
 ezFHc3fg20DVa5KYCNDZ0Qokegg2oXi6KJYXzi+bb36EtRTn63bw0oYcuxyWNW5knBeCXNYObUU
 Do7NoFXfzoPdLkZQ301Oq3EwCZa+CvVJmXu6UHn+L5KXUFZgqv9H2zrlvx/twyJTcOf7dYg==
X-Received: by 2002:a05:7022:1588:b0:143:26eb:18e9 with SMTP id
 a92af1059eb24-16a63386284mr23194569c88.28.1792009571412; 
 Wed, 14 Oct 2026 13:26:11 -0700 (PDT)
X-Received: by 2002:a05:7022:1588:b0:143:26eb:18e9 with SMTP id
 a92af1059eb24-16a63386284mr23194531c88.28.1792009570632; 
 Wed, 14 Oct 2026 13:26:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1761ed641ddsm23767833c88.1.2026.10.14.13.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:26:10 -0700 (PDT)
Message-ID: <75462552-395b-4d8a-bdd3-9ba5cfd8c0ac@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] exec: correct translator_io_start documentation
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261014194106.3205338-1-brian.cain@oss.qualcomm.com>
 <20261014194106.3205338-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014194106.3205338-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfe564 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=HwVCO4SVEuYnQWydJQEA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: pHemNmMT9ow0dZmyLXmjihyYBxLKfkbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX60P6/t5w/Drh
 XuH5auqGlpBmrFlwuKnclIUuMtmFPpdt/QXUN1hgC7vtJxQlelkSgLqBA+iLQZ0GPEHYU1NTt/L
 96/Z9cQkHMQKT/Rx7KGhzf6DYKGnt3tcSPa7SDdPGahfpmD0wlq1vm44vZ8PDFd2Vj4hbF8bHdT
 td7V65yhQ5GMZucipTs3AdxEfh6diZYY1xOVK5h2KzsOkoCPzcDFTypvNnee1ersAsVXLqI5Z7L
 g+nH6teaof1nTrGU1S1qRLblTI+YMOR/HE4Q3GuIdVkZCtaC8vb5oB90nXoF5pIfhvc0LCgtC8x
 Rwoq+/1II1jkvs3QuPLFW+hr61kVx+zIEWDY5CLGb3PCOtEv5uPmjTgivY82iN3dKSZWEYhzMtY
 zRc/aW/THKUkINhpkcRh6sdGbJovfoM8FiplUGhl+gQpHOUitHlqqnKr9SlM/Jwy5cR+mqsQrjP
 OaLt53uG/6Tjwr/pcGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfXwx5I15JRlJDP
 /lqdpHnWpbm6j9V96jrM9sHOELWCplBoGiNyS+YK4QhZ0b+FAsf0QzSycfx4/dXAibJENzbfVQ5
 D0IXrzFDYVvO+I8fohy5INGLT9/qgpw=
X-Proofpoint-ORIG-GUID: pHemNmMT9ow0dZmyLXmjihyYBxLKfkbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140081
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

On 10/14/2026 12:41 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/exec/translator.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

