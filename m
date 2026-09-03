Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841F1C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2GSX-0006UF-Vt; Thu, 03 Sep 2026 19:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSW-0006Tw-9K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSU-00035Z-MR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683JgUx11452484
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 23:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r1OwSg1HRToBDVGhaiCArpI8Iu8ERKzy1a7FmRB4Y+Y=; b=ZeMfg3Bp3K03AIoK
 ODhWyezZwuQUrHLiN8nLAZQ8jMxldfTJir99SmS0V1bKknBnlpsW+p1wjbdgL7Vr
 mWL4RaEGk0PJzzpKl0CMMY0ECwlpe3BYAlgR1rcU6rIkqwwmoM3FBxmljHtB8vQp
 FO/8LUDNfWGibOkpVmMOFOVZ7VAI0uVGuJMTHy6o6/2fFUBG+Hhi9uExe+cguaCs
 SPJDP67x91oWpww9jIpS/fv0iQISiRXTLpJqm7q7hxUlJRHbQuajAgdhElLLxtoj
 gsT5NOOoAUwyBskin/C4p32mxflRmwzXiZPgPfgWi5WjeHimsSQI1/PZ1K6tk267
 EkvoCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxh48n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:03:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f946461so71750085a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788476580; x=1789081380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r1OwSg1HRToBDVGhaiCArpI8Iu8ERKzy1a7FmRB4Y+Y=;
 b=BqISELurepMusBLGbNmjl3SErcdSNh1nIVedGbGp6BEWii3PgNVATDIaxwb0g3nDNL
 /stHSoG/NQDxHnAmMiQFWpN5ADafQ4cs4koyUiOdELdFnEiARrPBny6WXybGzG0S9wvQ
 ZjRVHVu8xH++BBUnAIb1PE/dSaKk1ZrhJneCKOAg0/+qibWAHmmcKIttxWI7fMBP33yQ
 vLsJj9f1nW9Ad/V0uKHiYBc0zN6uhY8U5xqzNqfbK6sB4jq55ZEyTY2UaOaNa/x67XiS
 6WivHwtf9Gsy4dtWs6MXHcVaJ7tl9dxJF+AazfOOYxAt4yP3qZVGU/QJ606PAwadEfSe
 YNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476580; x=1789081380;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r1OwSg1HRToBDVGhaiCArpI8Iu8ERKzy1a7FmRB4Y+Y=;
 b=Z43ix8p5QByvi2hdI2pvEN+jpjIX5AUwb2dC69skPLhZ+7YCFsvwgx/a2Bg8hU2JDk
 uGdvS0YK9xeNKTSdLIifqzB/7uBmiav/jfA4L8+LQK0ya0ff1K3jBSxYjmky0ltH4YTr
 r8lwU3GRn1AJ/dFP8uC7tSELq8jfATiP9ok4Hmsk2ku0IzkCtl9NJCcw141C146lXM6m
 Zu2cm/twLjbboDp/T7Nl5XDzCP/pOECRJQIISlzGym9GWcPjW4EIrP/WvRkJ8DxtSSW6
 s8JW3wAGI/YPopGXmhwcHT7xQFScTAaWws27y8phfRkJpN18ebv8wjHnx0mkEBw7Us7o
 4JJQ==
X-Gm-Message-State: AFuF++k56mUcrl9Rmk6iLhi7f3J8BYx64nZARj1R5461ZW/l6knrlpr0
 /jNTGvf03/x7THJOKNV4XG8Z61AR9c2BK59CTF6ddsTzBjzlzqIEiej0/8yygZ31IbHJJRSCK3L
 hdqQa+LZ6pIUaVyNvMtOGJ5jXJ6JEXCgY4tIlq0JM3uydY8Nz94RR+++z9cpQM8WsOQ==
X-Gm-Gg: AYBFou07WcwbYCzjO+x9ryVP/D0GoSKkSf5dbd9TXexWYiYwCuO6eyNN1ZsfpjLN8iv
 rYPUrbixkW3a+5KHSBk2meGq9F6BNOKpGp2bykqo/e3ailva3JZ4K9/6iHXX+DIQXRlALs/YRsc
 43UMWVShb/8UCjhcsDXlzXKBOyC5PYM2w9a4RMQr5FPrVwKzcydH0c7pmf32LWcHXpVKvusexZz
 YeGKRbHCe//4Ui7/K6uSHy6juTt76Lx4URF0vPEJ06/veGpc8+FPMKsByrFpD2SX2etyc8DFCPD
 BwSn/3lIlatITWQ694ITSn48PgADD9/khFR7NOzSblSeq/vFXSG40c02c92IQngwDTaSc61j+CE
 /l27D4PrLlzXuWvsTn7BIXaYmZEJCRUFu8WMzv2qP
X-Received: by 2002:a05:620a:1371:b0:939:1c1e:b79c with SMTP id
 af79cd13be357-939804441cdmr193317485a.26.1788476580246; 
 Thu, 03 Sep 2026 16:03:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1371:b0:939:1c1e:b79c with SMTP id
 af79cd13be357-939804441cdmr193261585a.26.1788476575027; 
 Thu, 03 Sep 2026 16:02:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6023edsm104238135e9.7.2026.09.03.16.02.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 16:02:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 1/4] hw/acpi: Make AcpiGedState const in build_ged_aml()
Date: Fri,  4 Sep 2026 01:02:42 +0200
Message-ID: <20260903230245.65601-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903230245.65601-1-philmd@oss.qualcomm.com>
References: <20260903230245.65601-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fhIrDkx27rtw3-aPacH_xAlUvxkSOe7l
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX5CBF63hNiQRo
 /GL4Mmd1cQiu1kw8gUgHfO96sEmMEoS0QQ4eFHHILE41wbuxriNnJ7wCveFnmPYyLpF89oUfNhF
 EdCIWBglGFkSgEJRkHj3b/OmbupnFrg=
X-Proofpoint-GUID: fhIrDkx27rtw3-aPacH_xAlUvxkSOe7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX2OfHN9mBAIWa
 fJgezXU9A1gDKeIUB/RClQ0So066H43Vevx5AYeGEBNOd3PusZDRqFyJkQFvklfups7svzVF28A
 GvJzoQkpU57SKtBTSP/IipYXKpWcpbSpAP7P7aIPPxAR3Jq1x1Hkcuvi6FJSXKe89c0VTcJTVXD
 YGFGGhtKbGFAxkxW3eaKJXTY4ffaeDQKeXl5/AUGqym2bhZgZCjcQM8KsKA50DGkz/2GAgKujtS
 CAQ38sLCqXRnIsPyzDZoZEkP1eLllDx+Uy/DTIwsCxijhpk8fvxhuTeN7QN55cL2rNC+RMeCIBu
 yDyOW3T+O0s5UQtCa4LpYyGAyddQ/d30Ssla5pRi7tsPI0XizSaen1z6cKy6H+nuv/dl8MvX35b
 rMRpJ/f6TkjofdQqawiggEHFZKij5NUjHgGbqFMGCbYeSur3PpIh+ObUbnY989ixM5zBjlzmmoZ
 SdyB5TzrzzwU6e7i03w==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a99fca5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=AgXWHBCjbjcJ53z-AVsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

build_ged_aml() do not modify the AcpiGedState structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/acpi/generic_event_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 67c9e9b3e82..5225e325132 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -48,7 +48,7 @@ static const uint32_t ged_supported_events[] = {
 void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                    uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base)
 {
-    AcpiGedState *s = ACPI_GED(hotplug_dev);
+    const AcpiGedState *s = ACPI_GED(hotplug_dev);
     Aml *crs = aml_resource_template();
     Aml *evt, *field;
     Aml *dev = aml_device("%s", name);
-- 
2.53.0


