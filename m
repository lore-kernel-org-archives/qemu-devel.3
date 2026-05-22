Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69835CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXDd-00035X-SL; Fri, 22 May 2026 17:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQXDZ-00034u-8M
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:15:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQXDX-0005DM-CN
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:15:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGal951733014
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 McQ5f11WtfKyBtGjwm5K16KaPpYoDd66H+cVKzvnxq0=; b=oJQl459ZPJIP/1fu
 /1vL64K0uMNp8OT9nfx+q1bQGFZeXO1pSHAYt68RJVOowJM25l4Q3BZiA4gGERZt
 9fj4aTo/Dh32az/HZWEClSMf4dp2JLRptGp84lD8HeSAhJXNnOQoNZFoZ/abAk1W
 7oG6TETqBAbtwdcwkkcFTD3qOO6c2vz8GB8Jterw7PqhOjJWCnJkX4Z4MwE/yRzS
 GuqCUpohOG6eJ2tCs/rLLUstHQDl8YxMOO4bLRZgm3Het/9uabsSHiBmoqvG1pxI
 sPyjihol/2xBn6GsalFCc5mOn/KnrZLdz8cpJPaF5g3MKPHEtWh3g2BR8tn/EAkL
 BM5baw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq8wm6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:15:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdd327d970so4338081eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779484537; x=1780089337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=McQ5f11WtfKyBtGjwm5K16KaPpYoDd66H+cVKzvnxq0=;
 b=j+XtRIPS74Rfu+Cehn3RR6WIJnMy9QXi7q7fWKywdZl4dgo4Xotis+vwqguiZb5rRZ
 2b0713rDOIuBEksDH2VP2nkt9w/zY8gzEp8bExHnRs14zd0zVJxkW7eCxeqQ0iphfMG3
 do8n4ZZmbu1doJW5seF/5UExX4k48zNjf3tjibk9FejSG8/bqM4M9tuSsCNgQ8BfUQfr
 6TeZ/+uxRdvKE0RTXqqTFoKHSu70g1JFQyvr9XGM9M5jqeuk+fjrfpFcmSDyRuoi1k6C
 O0L4yhD6pWPuiyYgXkVkLyyDPRhMVVHyUtIuXxXjLW3FKFrU69zr3rY0jo5LIFG4Cpp/
 424A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779484537; x=1780089337;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=McQ5f11WtfKyBtGjwm5K16KaPpYoDd66H+cVKzvnxq0=;
 b=L0gv+m/I1T/LVSaNXIMNVXBH5po71EX3vrUxyQJb5gsEwPyDtqS2q/RFLPq7J2zcnV
 MLQu17aYwOk9zLJWDQKJb2+JoIfAkH7Xbbq9UhKc38/FQgep4P5N0ThIC8bMnXu1YAbL
 HrfytOiDJ1iKj6UUwsZZRZpcqqLdZd7ujx2srGQS2BWSHPR2wDvdXMSAEuIj/p79FfQc
 eb8gsN3B4g3f4pi4PjMK9jmKGZcLRm19zuzqZpxRRqvjke/5G3aTgS2sfiEU/PpRAyIE
 Bue12p4akeG2uuiy06w3mPG7AWL16veiFDMQb3LfkFc/15jpF9yjWxzNx9kjCEZMM/us
 iYTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RBVozRy8aDBBHdZmNe1VrrLPxrnBa3OCKHRrCeeF+UcCerw1eGGjKXCMT5c6ujpSgpfR6D+7NRy1D@nongnu.org
X-Gm-Message-State: AOJu0Yyj19WRzwOC2AEM7yJfMBK/yl7gi3GftQEQDHvtSg+PlMEiysB4
 +LUTbKKGZcze5zMQ9pEnMOX7GL2r60yk1KDj0MRSTCcUa2/9r8pGLTJ5RBfzw+DF3fEWuc/PD6Z
 p4g5U5ojSDAfMN6h89pF643ODJWRAJiw+Fx6bkf0ojsMRaMtMxGfz7paHxQ==
X-Gm-Gg: Acq92OEaL+tk1F2FbnTuV3v5pMNZEf5yn5mxnoFeSDSBV0iaVVvpr2KtlBgUqNtWQaw
 yo2zqiUUDjAI3xohQcVugvvjsXvkul2zvl6/Q3WX9T+3LfN7gvHUxaZW2Kixpi2DUdR8wbzidqj
 vTt7GOP3RRvy1sqsZgnypY8lHNdKmBdH/+bpBeL6DBojt6/HTqSfcaHb2lS5sRMGpCBnmpKBHsp
 hXSyxqccFTw/mPDayV35z9h8sfvo/dxQUWbtvxGsygxraCVrXcnHCW1XpsglUXj3mLS4VTHYhJB
 +cm3/vzimDXoDBBDOivPHxFj+7bUzlJHc/Z27m1cmjg/eBb4b5KBNzB19WMW6VlxkhNFWDVshTt
 eZMyP5Qi1DzA13JbtpfksQGfubyPtAMFnRkUCkv3jRfa76H33WiHMBHxVHbbKbXgCPFm0nMHaRs
 20O6ihNV8poy+RTg==
X-Received: by 2002:a05:7300:5ba5:b0:2f9:1004:b2cd with SMTP id
 5a478bee46e88-3043109e7admr4981228eec.20.1779484536630; 
 Fri, 22 May 2026 14:15:36 -0700 (PDT)
X-Received: by 2002:a05:7300:5ba5:b0:2f9:1004:b2cd with SMTP id
 5a478bee46e88-3043109e7admr4981207eec.20.1779484536004; 
 Fri, 22 May 2026 14:15:36 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452259a18sm1966552eec.23.2026.05.22.14.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 14:15:35 -0700 (PDT)
Message-ID: <57a40000-2d3b-4b56-9bb6-62d5db639ca3@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:15:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/39] MAINTAINERS: Fix F: in "Build and test automation"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-38-armbru@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521080511.999266-38-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxMSBTYWx0ZWRfX/zEuHczw5mip
 z1F0ywqQ2YVEDHW0DuecwrfjmRSBO3l6zhH4Y3pILpZDCKbwJqB3OpC8oEQ4a2vTMbMdS/0/4BG
 VyUd+BNWwH2quC8dc66n6qAySmFzaq297ZzDlB1WZatVxwf+82xOypKcRaIkWFPNUxkgKbqrFrV
 pxYlq0gY/gSs6fbx/JxJksHviJgRGdC0yfxo/wpxWIOWMTdk8K/TU/Ajb1niKEsuHvWcNjYAymS
 YPDN80rDUTliAXa0l2qlOMgDDMM7MiUg7O2hOz6OriMg/8bcoW08oTXRJMIlVNGpiqOVoFM++OE
 UKjmgJzcZiDpjIUOdwBLuF+ViH8OuX8cMe1jZmXcsRXcg2v7Wyh6xofwbk/e6DX6uuq/2mvpXZO
 JThlNQvpsOGKU5g/mf+zHKHCxC1WrgQypawbfE4aqmNjqGA8MAtzREy7XBVyQLHHMkD20QCLrVn
 yzqrCXqPpefua+sPuyg==
X-Proofpoint-GUID: vfxPZhkO0DK9ilxr57d2GpGWJgGdZrIG
X-Proofpoint-ORIG-GUID: vfxPZhkO0DK9ilxr57d2GpGWJgGdZrIG
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a10c779 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=sW0KYcwGo6R--hFhfS0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220211
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

On 5/21/2026 1:05 AM, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we split of the testing docs.
> Commit 97b091c88f (MAINTAINERS: Update the paths to the testing
> documentation files, 2025-06-10) updated it belatedly, but missed one
> line.  Correct that now.
> 
> Fixes: ff41da5030 (docs/devel: Split testing docs from the build docs and move to separate folder, 2024-08-30)
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

