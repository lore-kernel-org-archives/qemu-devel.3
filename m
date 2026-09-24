Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337F8C982FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 04:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9bJy-0007lM-WD; Thu, 24 Sep 2026 00:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bJg-0007kZ-MB
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:44:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bJf-0006yH-23
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:44:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O36mFr2096587
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1X7EvC0J83BMgbtYQyi3UMhoOg1X6JU97+CWZ7Qjv+4=; b=MetBcrNwU2j3Jr8U
 zPVENIWS2LeqhKKG3iRCRP4fG4WGBszcB2kKU9Kbuw9TKMErTJui6G1WEu8CczJT
 Z6PjlfIAmEMnTmqUsSwvbA6J5kYUy4jWRkycCBvBURM8qTy3RKzX3nE6EfPbXH9n
 LG92b0kGVoHuih5rHfyhmIhIXNK8VyXB5IYcdesRUbjMJJDJvfpvs8S5ESooLs2y
 7HmsJGZ2e6aeczeENTVn5ewTjNQ2G5gYojwZpRLkpeV0qQYGG5X2ICPYmuK6h2f3
 /L9kwbBqG+rowITjLh6c/SPAI45hQTW4p98Fmm4tW41hC6zvzn4sAb8w+x+Wwsb0
 cTiYnA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstugnjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:44:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so91783985a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790225050; x=1790829850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1X7EvC0J83BMgbtYQyi3UMhoOg1X6JU97+CWZ7Qjv+4=;
 b=QecRAvvDo+vO8wEvcuKvar0ks4PGDL64ZwSYA5bWrDCYOe3DyUxjndkkpOYr3hzT7K
 urRtbgEyFPmsnjZ4+RqrobIuaQ62TDKII8IQ/g2q7c2Bjg82eXv9jt36vVz2XyF6/SVX
 /jp6ZG8AzezJXbcCa8F8I/unqTVZyRFIs+LqrdlT+rv8Xbe09ITgTSoUT3Z+rQvXv3Yt
 fu1JnqWCYIc80lRuDDI56Zq0euUd5tfsEmAY9fk9VCRXqPi3++3HEnQPJSsaAw/LIp5J
 T9Zldmsawvv+bQAugxWR6vDB029DjXMXJOwo7bBz3cIzCaOzpeAoAtYS0Dufp7yfVi4Z
 c4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790225050; x=1790829850;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1X7EvC0J83BMgbtYQyi3UMhoOg1X6JU97+CWZ7Qjv+4=;
 b=ZbcqUwijvRXQB6tJmavSi5JFx860SSBU/Rd9AEvnXHHeKWUzIbdW4sTGp25gHXI94P
 2h7fsFw6dyIcv37VS4/orM8J1kH8fxX4GGfBPWsR5LbX0yYnjv7SAorwpZ0+eYTePYwG
 X5ugcXAsrLmua+D9yQhc5S5UQv3Tk/jm3rOFCcrunLYXMnuE07XKBtMrN8u1EAdAUEwI
 laLe5jTF0hYtUAnka6tPOXMG4Zg36kR91qUgn/DGimZsggj3RPgsZoQBkpfqpRpKm8PG
 vxBthw3xE0k2kWRKTELKZPKw02FFS8/vLi/v2w9EcLv50MBF3WBecCAogHujxicCl9a3
 eXRg==
X-Gm-Message-State: AFuF++lbqdLh1X2etaTTIC78GhE4avOEO0S7Wl7oLY9SklK7N0aK82is
 hmtzTJZg/hhZS4H5RkYYRggc06tqDNfwHWxG/Q8kW81PsSDFLAeu8h2lEEgWF/Dvns88qwlY1rI
 sGIgYNx3UdgXH4rYnUZ82/nAcxCL3jepFHzVp0WygqOFhcJfsBD3zow1Uzw==
X-Gm-Gg: AYBFou3Bf3o899rc2pZL3clN8HkFeKYmu6ooo4BNfKjsyE1DG1eo0GVDBFALTcgN1o4
 4OVJCZJVUMibe8JUJAnFksoTjJ3MopCoz1jFy45NAhqTmnq3eXm0zXRJznL7MISVB92WdwFKB7M
 NTX1bJvojVpGIpATymwFyf8lhk0zhOtHhD7hVSS1C4IF4FyQnK6hgRLWK79ic0h+KyTzUFGwhm/
 nkkuw/RXZQ0xpqk4ogWqkXoHY6ADU5qexrRDd45Wp6JiijbjCXuU6qBdeFw51bZak0Qa3OJ1eD0
 jwaP6qCCsyZ5XIiQCLx/sS0R6o4vsaYKs2A08b6l2SkhpBEhAFuet1o1OHTN11I7b1r27gJAvWc
 gvRJSwhhfwm2uqZaqypla8oKL99nnc3/p1Q==
X-Received: by 2002:a05:620a:4105:b0:93c:204:859 with SMTP id
 af79cd13be357-93c366fed7bmr110242485a.21.1790225050528; 
 Wed, 23 Sep 2026 21:44:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4105:b0:93c:204:859 with SMTP id
 af79cd13be357-93c366fed7bmr110240385a.21.1790225050011; 
 Wed, 23 Sep 2026 21:44:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b9c288sm35868465e9.2.2026.09.23.21.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 21:44:08 -0700 (PDT)
Message-ID: <0f12d041-4bca-4bd0-a830-be796f0f9437@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 06:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm: coalesced mmio: check lenght of the MMIO write
 entry
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>
References: <20260923164631.306314-2-pbonzini@redhat.com>
 <3d89eb19-ced1-4bdb-9f2a-fa6eddecce49@oss.qualcomm.com>
In-Reply-To: <3d89eb19-ced1-4bdb-9f2a-fa6eddecce49@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfXwK6P2DriYguS
 jocDPQcFd7F1d3fNviIf2eHbRaOkKx1pxKAH5MpCdIQ2JiH6LmgPZGKg2iU9Y+wJgnDGyoAWd+T
 z8Fpjzx6r7Dt0RP/bfvIg+4sbYsPZmM=
X-Proofpoint-ORIG-GUID: 3cSH9e6GrY04QPRpgVJMGIXBq2KBiyi9
X-Proofpoint-GUID: 3cSH9e6GrY04QPRpgVJMGIXBq2KBiyi9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfX5E9mm3+9XgVK
 f40XevotsjX/OADfvypvBgxq7Hq1s84rkiyJG1ySwwuYeYNkbICbuVEu662HCrlD7wCMRrMC5Fv
 ujxQxkKOIC4ShrJPRACpf9vuYZ378sIDTD31YnDkhAekhftnGlO5p+MlGJPjxtTeN45Q3bVRszk
 TCmc8ywwhJNPlNaZzgJ0d6yx4qRKyICcrP0lY8JSORyyzregB0Y2IrUTjVzBBCyQvFWLcm28zlf
 8IX2CDBA0OU+c9QAH1aplBy1F3WuOx8Pbyf8D1QluGyFkU2XLj/u1VKHdja1o12ZkfKn0CxybEs
 v353dldRPtSP02u+ZUMICKxQA8VDECXXi136R9maLTb01JzC97zbLsYB4Lb2sNkilmSJjEkYHin
 h3n/qq0amPanCYd6wXIWzWQv8PXdwqrqZ7F30jLbcgKYQybY44jPDZPpeJbWP6Y2KkqcVVDSBJ4
 Mo0nTUm0GgBRUNh+1FA==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab4aa9b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=69wJf7TsAAAA:8 a=SUrLXzmtCc4iwyD5-EUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=RVZrT9e-0RoA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240020
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

On 24/9/26 06:36, Philippe Mathieu-DaudÃ© wrote:
> On 23/9/26 18:46, Paolo Bonzini wrote:
>> Queued, thanks.

Maybe worth adding (also to the few other Maxim sent):

   Cc: qemu-stable@nongnu.org


