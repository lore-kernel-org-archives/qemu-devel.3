Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6938DC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi736-0004dB-0N; Fri, 10 Jul 2026 04:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wi733-0004cq-7g
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:57:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wi72z-0003lo-Id
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:57:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7eeNP092368
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ilbqXyvaK/hyxjHXCWiec1ZeQUj4EWNbu0CeUAfZjGA=; b=MPHts0j3QBibtmZn
 6K5BZv5tMM5Iuck8pp92GamMSHR7uP9mtfkbrCsN5T+C+kaeouR/2H58Nn+GFzS3
 0w5UScUUzOGCIroRy6BpMskA0RiLhlD0ZAEfJRWCS3CMy3EHx2b4zNI+tvLKKUCL
 I4/9Ak8d4dZc8CMSGzXd1EauBgd+WXCJjZRnmAbTC3faiPYxay119YQ5+2o8ZXOq
 L/rOvws4dZo94oT6ZeCUhyTghTe2KPvsvwICHyAXTNG4OrZHqVv40CDFCFbK2lCY
 A9iZISG3U/wW+Asrlv+vQyji9j/2ounXNvKabhaT4nV4cfUmsyZYSfjU6zOALg9B
 oH2IAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbv0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:57:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso6309701cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783673843; x=1784278643; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ilbqXyvaK/hyxjHXCWiec1ZeQUj4EWNbu0CeUAfZjGA=;
 b=j13tOJeHDyJ4Rgjonak6L78rlwopbHQhNWi7eIn1Wj1YhtEPUDErIkMyW2SX9Ym5FJ
 AGAvM7dVl1aV+RSIqpxmyriT4Ydbg/f+1nXSIqyZiCELVTx1Y8BHNjDNkaQ+JwB9CNtY
 VQzxuaAqAjDC4Su6g86j/GfmM+C9c5D8nBzxREdVGHLGO2PWIfohGRtgIaghzii9Yi1B
 vU9im7nyo9lRvFVeBJ2YW0Z6MRvh1Q9TCoswjLWgMnbopD/o8SSOIUqxJCk1ZRYsMSTb
 /0ZQgRaYkfKzx8298YBcHk3m/wMJjjKnmc6HBzoT3bYpVvqgnwF9/LYeTw/ELYUIVKxl
 jTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783673843; x=1784278643;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ilbqXyvaK/hyxjHXCWiec1ZeQUj4EWNbu0CeUAfZjGA=;
 b=R2mZvUIT0br7H/IdeK1VqzGD95IkOdoUp1etbrrkkp5wL5/llXMVrzqp1ayIIJY0GT
 SxuRQx1WsPcwj4HDxoE3tVrcqdgTo1ujz8hrO11sGrK04V43oHBIdFdI1VBOLfjxtG77
 CM3NFr6WFH20QO0jBg59DLHZdrhRibprzJu/200rFmSjaaffezCEpaKEyT01Z48Ne9s6
 +P07jIa+HXjfTacBfO7LUjw/KxUd5urm65WvPVYjY6DrSpXVGcK/QfLeie7jq8KfDdfJ
 gx+ksDG5BybaF/Io6b0MaaeiEA9wUYOdTLncMbw4isPDMlcv6YZD8n6KhLQd4gvUWPbD
 r0Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrv0VG3euJL9FN/LMJ/qWbWBna6HQ2Cou9TFBGsW61N9F25qXN/H2rjyZjS2bGAzP+Wbm/ShN+ap+qo@nongnu.org
X-Gm-Message-State: AOJu0YyFP1/yUgDAyVEwyJqG40wkOTfRQ5PQemQk6RbsaqUuRcL0Mfu+
 cv3TwL1c7sZsauDSD02P7OTHdx9/Gj92DEA8XZJ2YYPKGfXKmK76z4jbUzHIE2QV2E/KUFKkV5i
 R/uJoBGPd6/q3ec5TtjGsb4r+YFGP55URkrtV3fhbYVbRGRYF4GuPGcDnBA==
X-Gm-Gg: AfdE7cmYYv1ChyMCzgLRwf/ih7Xf/R6EJVSp3VPHpjbumKngWeKCtCZckyXaol23Aqc
 jQMR4y6f7xyi4qbVLDT6oGfqLijKhxh/qgQKta6d+hizckS0TaYohzWgTDOd/PG43qrEj/1+Ztj
 X/Gc4wfs1E6CyO1TH+PeOKOhbop3jlpsnuGsGVeAm344a4KBvFUmvA03UvAU4e3tkGaD5MsqKAl
 JTanIgB4A/nVUWS7hif7OqBSS76UTDyj/Ns/9wh7RCRxII0lgGXx7ecfSTN1k2toQJEnweGbIDr
 uSajapGwnvUlvfOQHRbHan16fuAwHAzxd42i928zpz1vyugm5c9TvPHqkirsCoUi3je8TnLMEZy
 KsMxcivHmhDqxnG6Zn8m5Hve5nGQWzXQ=
X-Received: by 2002:ac8:7d46:0:b0:51a:8c97:9378 with SMTP id
 d75a77b69052e-51c8b3fa402mr112450791cf.64.1783673843057; 
 Fri, 10 Jul 2026 01:57:23 -0700 (PDT)
X-Received: by 2002:ac8:7d46:0:b0:51a:8c97:9378 with SMTP id
 d75a77b69052e-51c8b3fa402mr112450581cf.64.1783673842661; 
 Fri, 10 Jul 2026 01:57:22 -0700 (PDT)
Received: from [192.168.69.219] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm58222840f8f.8.2026.07.10.01.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 01:57:21 -0700 (PDT)
Message-ID: <53e139ad-02f4-490d-9d5c-44d2f495c336@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 10:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: re-add explicit gcrypt/nettle request check
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>
References: <20260710075113.35631-1-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710075113.35631-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4NiBTYWx0ZWRfXycfTshJgK3CT
 cVXFWIrBvqXCDoZh5OlfjNNua7MHGxwTG6lFV6UlAvzfNe9oaL57Uc/lAsWvY4IEJ0XqFk2IZTn
 Km0H9mRxXI3p/K2C2RQfh3RpZS4SaR6Wf8pZbc2eglzB2ZyRnaIdKNqQvqwa0lKmuI6XdpiTqg9
 ZVi1VzLv6ixgnM/Y2wfGnEIxHPD+JhLC/7Pj5je0lw8hJAfjrR+45soY7P1N33fDxOS1R2A3jJk
 ZdrazBMsNCP7DSGLsr8+sGGlAfORZ2bAe5jpeGUMi8Cdte6in7p9xy+ArwiHg9bWNV9Ki3ATpQ2
 T1O63xWfdQZ+1xnEpfedhIs4fclt8gLmDcEIdaRVms4OCH/cuv9rAAm3mhWa2LgDYotF5SD1H4N
 PxywnejbS8Ja4ETdgwscX9aM7wtOd9MpndEzhp5w9kK/CgihxrbuyqAlVy271URom6vyNsyft0B
 3cL2ZyQoE6uUSORfbDQ==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50b3f3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=0lgtpPvCYYIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: O_mZa_REhOn4j_Kg4argUbn3vbOJofy0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4NiBTYWx0ZWRfX89MZhQ1AShXe
 xLOZVBLTBrV07UEsuE2MGuROgKi6GmmloLMQirRTVI9ZaY/0tV8QxQ7WedtrPHeKWPYBAuh2O2o
 HcgzDXccjoN50lD7mni+tYDa80d513k=
X-Proofpoint-ORIG-GUID: O_mZa_REhOn4j_Kg4argUbn3vbOJofy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100086
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

On 10/7/26 09:51, Luc Michel wrote:
> c4b3d0074 removed the check that nettle or gcrypt were explicitly
> requested as the crypto library to use, breaking the --enable-nettle and
> --enable-gcrypt options. Re-add the check.
> 
> Fixes: c4b3d0074 (crypto: bump min gnutls to 3.7.5)
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   meson.build | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

