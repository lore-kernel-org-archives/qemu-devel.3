Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B2C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzI65-0002K3-3G; Wed, 26 Aug 2026 14:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzI63-0002JR-HH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:11:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzI62-0004ep-4S
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:11:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGuqH81541301
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dJJDHyKkgiP6QxGZDNOvMkdOgtqf8YD7+eMFij3EVkI=; b=F8Qh0QGxlDCFTnLO
 Ww2k3DlTN7QiIkFHLC9La4Gpv76nRpcYazOOG+Z+FuWdI9+nVQE6IHrq+Q5KEEAF
 167yY78PurkA/j2R6YiEwOK9FTtCd8M6tGLUrzHLEe5f0LMVONipB64ysppr5GC5
 +8Gw0+YXVYdAYNyJAJ/79PsdohrdmOV0fZmT65jHfnt0ZibyVYAGMcZ1p1txbqRb
 vsAmN8iVCL6WIjodM986LixlMJujO4hQTZtqk4M5uRIG16qNvQjkm0emtTTsPXIf
 PGg3nXnfGVbMac7pHWGpKqr2qNOx4NGoJEKF+JLPKHZ9SBOoOIypr/02p4ur4UDX
 004bww==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0759d1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:11:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d9cef8d15so24102071cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787767891; x=1788372691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dJJDHyKkgiP6QxGZDNOvMkdOgtqf8YD7+eMFij3EVkI=;
 b=NP1TjlkFyH9PwxxmGBvCeN4qUtfMtcrNwPPy0XkDGPLBfhvZ9SUPwbDkM/wutnbCpU
 UkAOJlPAebz5Sgj+EYMtdxL9C9+J97h3EY8KA4lhDTpdqluXL1xswcu73n5DQiPbphLX
 MwDoK9JJfEAtCJSnHde/h0ZbLx7tj0myTtsvsQkQvC54edCD/O26+eUgZb/dDnEz9ui8
 qaminSF6z2WPkmOwWVv+YhgBFEj+qBs99G6FUITB7a1YAB6JwrG/GV1vNaX6JnRVekbc
 rXZ6iSgwHQBYsJ5IFv8xAAH1VJYkgzTZoonAvepmk/hnhEOkWyVg71igDAoXPat44h8I
 GRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767891; x=1788372691;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dJJDHyKkgiP6QxGZDNOvMkdOgtqf8YD7+eMFij3EVkI=;
 b=sGmzPcsfHxpeZ6G/VIKQFoXAHVvKR2v17U6P9LChREkUBGXbXw/S+U8koVAXaar3Gp
 5q6F6s2k6H2Q5rp++u/oRrejXKFY6xajY+1XMSWrpiDbsyXz5luY1KN4xR5xd4ag7Nsu
 sqYwJBF27+46RrNKxDWI3hcfDcMV5GB3f5+8zu/ZrYfDKMfqUQl2OGPbsDyVf8xFq3/D
 5DSy5U17nIDcY2tFww7Ml4Tygg75qjibaHRoJ70QwFmSYRS/h1niUTPDf8fGOGEQutUM
 VvDTHW293tCMbouToT7PBlI7V5Ka453QHiDiH6pFysfdjN8weN2hQlzSLfza67eeAnVx
 4A3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBq1vQxncFs1YwGm65xkaRyfNN9ilbGXBzvAps/IA8hrp+r+ZWTT6btIw8AzNB1do+7qVoww9QxWjp@nongnu.org
X-Gm-Message-State: AFuF++kdgBWzDiloeN5S4Zx7kolegKwu+xOw8e+UvKD3tJLvxrQfeKqq
 6xafPDanKfqHKTmmdwBMv2wrJDJTglsgOIzNgJQwUuCgWKJtzD8Du2XpFlET2PfTLFKlZ+GYo9i
 cU2bSeESc2vnrLJX3ag6BnOGKEZjsomZau+v74raTN7TitV0iL6nlkIgsQQ==
X-Gm-Gg: AR+sD12mQJzLeK4wj/BVE2wrTphioAOySTz4LVtb53+uCOAAKhEPlhliBFnkqV0JzQN
 yUeWG/iT/4nF+kT3BtjkmPbzZefXtb2pQUONMdkbsHV7TJ/ogwYP+2hBBEbmC9YvrKNdMFMHzZ5
 MHrlWYHAQ8mKJ1CEN2AyxVvybGQ4rt+oMNM+KFDE1s6TEQQV6ol6udNEenLzCpsv6ADIPKrJuYa
 OrRh+O0lWAfrRq3+dESymyo/YhplUuc5LP5pQxsc0AvfTh5KuOjMwadn60DTEMm7TwtPt04zcne
 8EFvnsnZ97M84ZKG9GUjTAAd9tX+mUY7r/Klt77JYGi8iORW2JcZm760Yh1E9/4eyO8Nvkk5ODK
 D8Owh7+nc8dvl8HA+L24Zsij5ekjZJYvQjF8b+GjUHHOvx3mq
X-Received: by 2002:a05:622a:98f:b0:51c:217f:518 with SMTP id
 d75a77b69052e-52e4222dd55mr88084741cf.6.1787767891439; 
 Wed, 26 Aug 2026 11:11:31 -0700 (PDT)
X-Received: by 2002:a05:622a:98f:b0:51c:217f:518 with SMTP id
 d75a77b69052e-52e4222dd55mr88083991cf.6.1787767891039; 
 Wed, 26 Aug 2026 11:11:31 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83babsm5615341a12.16.2026.08.26.11.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:11:30 -0700 (PDT)
Message-ID: <2d0a87bf-dd2b-4e34-b44d-c19f69923565@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 20:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE
 to a class prop
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
 <20260825134320.1039012-17-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825134320.1039012-17-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6Eqor5pPimP940naMYzv4U_F5p2sXybh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MiBTYWx0ZWRfX23ilGPvYaBQA
 0fI+xcYARcnHRGAw8LzX2zDrVQuIi5onx5ru+kJnDaH0PFqlD7JVon/c5DVVriQBjlfOCbPBgV/
 lgLR2T2qygfZ8QviIgZJAXmWnVzMu3D+lMaWDczETyUBgXBUywp1/jmSEb2vOglucbC9iUTlWtU
 rFR2Y6flWMNaBI+cC5z9FMmCmE8AYHocw3uV+q10J7GZDmMZlIXpGztQyKQJb0nlxy6I+4qEED4
 l3Pr2QxCbX2bPt4m1r+Kl3MSvyrJNFrILFitHNm7TTrgqI6yArUUb/fP5eBPdUpyNke1V4RAw5R
 d2+VchtlMZfLJe4brJi1QtBZILnY9aQKPx3Pai+fsyqXfC5aOgiOXnQXv3NztAXOQr3rNuouAou
 dNAOdJposzJ5zu9vVd6aQnMpzgARwkKoq8hdA/msYAEvetjXNWNiXvdtgwvFq+TS2LfHfAEFKtp
 /021JRn4L09mOVzoVcA==
X-Proofpoint-GUID: 6Eqor5pPimP940naMYzv4U_F5p2sXybh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MiBTYWx0ZWRfXwlbR7Tg6BtWD
 D660eXUfUSK/ypTbTPBbKppxrvU+ddSK2GgyMnhcVMEbZthf1Sds1cE0+P/yCItEJrVRhMJo4WX
 USeJjWomooYarxQ/CVudvKcseGSTaOY=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8f2c54 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260152
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/8/26 15:41, Mark Cave-Ayland wrote:
> ACPI_PM_PROP_PM_IO_BASE can be converted to use object_class_property_add_uint32_ptr().
> Remove the now unused piix4_pm_add_properties() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/acpi/piix4.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

