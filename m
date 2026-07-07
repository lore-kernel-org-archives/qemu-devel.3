Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E354DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzEe-0007ub-G7; Tue, 07 Jul 2026 02:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzEd-0007uF-8T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:24:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzEb-0003o8-S6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:24:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6676Ka7k2922690
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RbtUdyPvyLJl5EM3naMwtEkOvo8zproW0nanVvouX/E=; b=eqK4vJtgstPXe2fu
 ff7C1+FzbHDQ+b/J1UHIL9p7vtl+6le0Wf+Bu4c4CCEdJ0tKZSP5htUhD+Mmz9lg
 LLw7PXvrGu3jGjs0QJdDKFy7XbRj3NF3eP4zIlHnMFF7J2U1KQM0WZ/BMz61JwG3
 Bh9NR3UBhCIXx3NTZYC1jaytCnZePyiU8amH/fFEwMltqSBOdh4VnBnSfe6430lJ
 fygpSzoABglt+GMTFrMCgPdlDBfU4oymCjjCswfTekpMCODitkjXLiUaDzG3i4Op
 HiSpsDIZSwR8qOUWFiwjQ5d2KH7GTtByFfD+pWS1DpekGfkdzXQRMR8Qea8S1+D5
 4IwqrQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t80f0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:24:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so29896321cf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405484; x=1784010284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RbtUdyPvyLJl5EM3naMwtEkOvo8zproW0nanVvouX/E=;
 b=V61+NnMBWJrw31PWLSH1lCrDWhq66i95Isc/fLMhL/LZZZmrJBH3drAS07oUAeTRmv
 tYjs9VWgsVqgsZurHvJTE0M4tnLMUIVFWdlk+rxGleWBq8yH8Z7B4AYKUHEY6HrbxIys
 fFxMGC8GtWB+SFGSoDytQRh+sHaD6nX9TYUMY9kpv8xXsEcvTgumCrauDgcJGIH3ZdPI
 Wt03ZtJ0RWVz/561yD1+BezJNZDOwUqttw4caMZfRelnLY82joVuyq220VLzrwsjrnE1
 KmG1ETJWtHJq5SHDbFNcly/KUCr8n+1N2JOLu5H8S0AXMWsFOY+BEyj9IrsUmA1HTfH0
 f8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405484; x=1784010284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbtUdyPvyLJl5EM3naMwtEkOvo8zproW0nanVvouX/E=;
 b=gXZ5LaOde6ApIwo7uP7veH0qxFZ5VsJyM0zs2i5m6gOo86f8oVjW6xWtGgfTLrVGsE
 2wcL9vS2e97N7ax+1BH6D8M0Hg3OWYMOIdO2CYKhkk7+qnhbkQNk8eo/bxGbZ5CTC18L
 YCI8N7vI9pYbrArSfoubSmJVhStUVyNcH4RRcBn3d+j0OxyPIvtRPsbzSUuNqeTjkxzs
 iYhGcaMZZSdFwFRO261vtppKi7ZQT7cK2XLykxgQ14fYwsA89A3A3N7X4Yj5sAoaT74h
 eFWgoSJyZdfiLYfArYLcVfM1d4rLhHUtVipDxLvLDg5XNNom5EBrSOztt2xiZA7QpFbc
 Srug==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdPVeli5AHBQY31ITfNR6COvG80YbNNvm6G40FrBkRMvg3p7S2RxHSRoyYvADQm7xwVdj9CPzNv3d5@nongnu.org
X-Gm-Message-State: AOJu0YyUEjbIx8w408dznElYXmQtW4zCzU66oyOlY1nfXKnaZo3wW1bK
 3b9r1GBAGbP3adPQ9bgLyPARL0sF3X3z2lITDn+ty19iBUvWUUxV6djCSs3p6EZYW6/hFW6iQgM
 dgLlvmkvosoMF2OWISIZD9xqzMsB+9CXy+ltLNNopiAwoYl3sOUUC/cEo6Q==
X-Gm-Gg: AfdE7ckPuEgguBx9bgo2hv5QaW08V1+2HS8kgD2xVzdwD5GkBfnFC6szWP8iE11gf5A
 eEqLEx7f1DNoqBuukJb2rKPSCv6ugSQXL6dsyLIhC8vxgxEyhvY7V3RGDeg5z0ftIcyO+BIiIA+
 6X+t/LewMJLqapBSiDIpRkND1Qpm1mtuu6WianDp+9RVwgCX1g5+x4MA1zLWNNkE2yGsxCKKYkF
 tFKLrziXebSyKEbJGtw67StV5OXH9q7hKIg/A0qRnVji5bDQd1K3bS2uDwkeuUF+TD1wUHIWzIu
 v0/2LemVDXSjVHqxTZLE0UODiDgNzWgfiF+D0EWufI1j58ktSB3HNDHm3tAgTp4zW+BHLNabwFJ
 kB29AZph8fyie9cuRpn/IbIUnENrM0Awb1PrMiw0RVFSNKRCt8uNzPxn8MEU/yA==
X-Received: by 2002:ac8:7dd2:0:b0:51c:1c2c:a8bf with SMTP id
 d75a77b69052e-51c74855e98mr42853781cf.43.1783405484322; 
 Mon, 06 Jul 2026 23:24:44 -0700 (PDT)
X-Received: by 2002:ac8:7dd2:0:b0:51c:1c2c:a8bf with SMTP id
 d75a77b69052e-51c74855e98mr42853621cf.43.1783405483798; 
 Mon, 06 Jul 2026 23:24:43 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0ec6e64sm49644075e9.0.2026.07.06.23.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:24:43 -0700 (PDT)
Message-ID: <db837608-c5ee-4e8f-ba6c-fc6b855a1639@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/91] tests/docker/docker.py: return error code if
 probe fails
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-27-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-27-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tLOQp227Tc0VMqTIqOmw3X9LJ8L-BqDg
X-Proofpoint-ORIG-GUID: tLOQp227Tc0VMqTIqOmw3X9LJ8L-BqDg
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4c9bac cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfXx3LRVZw9O9hJ
 YvdiLrKJtK9T77duu/TSlayxS/1FC/JLWuDdfbDea+ZBnHCWrlHEXV6fyGBehAM/aCvmbtd5O8x
 Ju7JwPWZyjdsRLG0sxgfF8m8efiqLTrBNKtd9a54qbwAXj1DW+LN0FdAQVVZcP2WDBQpTNI41Ol
 Mb+0xymuf3Je+xCbtu7kTgkjCsizH1FqVZkufkzlPk3p3byV0qbFaPpivDt3GyX1holZ2IGc9j8
 9qqMUu20PtA0pYnDopnJ31qWQrXJnmcR8FvLAZ8Cq/cx7Wi4Jy0t52/Y/TyeJJVuWvy5Q+DCUwm
 lS1zd7blwrFgYff9BQdMtevSNi5yu/iIbtejSLUdlfyNwVZN0aI+xkX31WmOgM7zOkoyB3TWyHO
 Pt/IK3Pmv++n+SyAuGo//5cUkag5vmT0AVlUwDT3HV/cwh0pi5ctX+63SxBb8JOtoF1yC/LMHt8
 x2ApPjWYYf8s+PkJCwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX7QgRD4gfuOyc
 HHO4tToeb8MMJ479QyavZ4s7AJ26ZOKSEovhTZDQYd3xMQBot1XS/8jWQw0HHAsCu0LGCa581D7
 WCKTBY3w5ZPQ7OKlo3URSWEw3i9NfMQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058
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

On 7/7/26 00:32, Pierrick Bouvier wrote:
> We are not necessarily interested to know which engine is available.
> However, parsing "no" as an answer is not intuitive, compared to
> read an exit code.
> 
> Thus, exit with 1 if no engine is available.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/docker.py | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

