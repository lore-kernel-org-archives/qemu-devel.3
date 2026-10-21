Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39AE606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GiyCHgBK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MVnw0m1F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLHe-0006wC-CL; Tue, 20 Oct 2026 21:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLHc-0006w4-MA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:38:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLHa-0003JM-HX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:38:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtoYB2795597
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 05pHdSy5vkv9mIB5at9b+r+bI6wz2OkVH6Hc5eX3+pA=; b=GiyCHgBKrT+A4UhE
 9qFNZ0ZyUkjsVJY5OpORtUdRvh8iJHfWVvrB+eD6JMwitxckEg/4QPk9kFmUZevD
 LAqFpP4wVgZYu0EY+cUe+ou57DCSwtLuXcFT6hDoe9ZBnAPiyqgZ8xeZPWyKvmPI
 PzZPGA4HvGluNovT3+ZPRvrKNP1BRXXIWHqwLZ547raSlfabhINfwaCL//4pfEXG
 RlcZD0mICjlQSKCQS7d5jx13KOFhJcMNU7+O0v6JEQXPtKhBWpo/4ZTF0TaB6CAI
 10GK1B/wa/HZu5nGDTz405TikIDHCPM1yMZX9PLG9H93Vyrzahxq6QskekRJqijq
 0XHVfw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2axpy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:38:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so79254585a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792546700; x=1793151500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=05pHdSy5vkv9mIB5at9b+r+bI6wz2OkVH6Hc5eX3+pA=;
 b=MVnw0m1FqTNhJS2l/kR21L2saoRdgtdkRFW8zYp7An3QirvwEHnXw9z/KUIkrFNAZT
 6sc5ckAt4bTDJMTFipQRMQQkpU0eH16NqhxDyPp0y0gDVvM0gqRmWeNyWfk89WxZiKlh
 R5Omfm/drYerqMuz9//ykC1tfYkymw/SpNC6ABOUaPY9M5uG6SI48FQGrg9J0nZfdTL0
 FggkGR+TL4zQ00ViIZd5zl8zzV1BdZ4Rs5O5vjkDxOL8x83+TtrFRSAESOo8QwSQIN8W
 tB5r6JI5u8d9D7BubGJp9WFZl7Htd/hTC7uEx80DY1RMqXjr6+Ar5KcypLJ4i9XkVLd1
 mtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792546700; x=1793151500;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=05pHdSy5vkv9mIB5at9b+r+bI6wz2OkVH6Hc5eX3+pA=;
 b=srPSHqj69wyHn7Km80jQLG1gN5SL/MeFkSm0vha+QcUAcl3w8vf7qgdz6odYt9sS7D
 Ami2Wl2Qok9gxca0uAQ9sO8Vn2T64vHijhfIxFtiEH5IXzD5z1pFHyWPA/WLAMgaIQ8n
 dT+8pncRcrG6KG13kawhgHf+bA09aizCNDYKm8Vyl7DXvXZnp8jb8mW9PYzIgLSowDcf
 ux8ihrlLGKnAcR0DV1ukUmaFvwrWbKY22UNQsUSCKJYhhu4gRnHjPNFyXYIAaWknv5rn
 jXzpkW+i4TLscObBHH6kaOHroYRf9ya793UW9yYChIZT2UZaeoBld5sumFE21TzghW8d
 +OCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx63TTjS6HoTKwZH0oVw6vm5b4mUfRnY1fxrVZGjVecJ0R+3g/0N0UK7ZUxhMJy+EwzJRrEIuea028V@nongnu.org
X-Gm-Message-State: AFq9FYI++MHXdp00kjbjPRUQ6cQz1chCEfM+zyMaWedNSzN+4ZBusOCY
 5Wq4NXI8NmNe178Xj9IpMiCyKpjYhKiziMPJP1oNMb9ypx53zfNtmECNYkMiD0Km6qyxK51s926
 bcmgbYLg5dfpy1DsFo+3A105gKyMhDLIfnb1Eiy1ArAD927zulQntZ2cMWNAYQsy+MVOE
X-Gm-Gg: AYBFou2j/L+U7jGCh/P9fp8CF5uVY5PSuMSnp9ZI0rjw+tOVb3XtMjpi+qtTcfqC1d0
 48JhcBP3kWD6DbYX6PJNivRL7o2+3dCNg2UaHSBJBgAIrxbr7FriOZWTM70xd+xDKBDY2Gp9sJ5
 8MYfmjVaHZdX+qx2uQVHr3tKp2nZlHV+PrK6UtES6t03vxS8mgsnM2Vyl3387LxvBnZ/lmjmT+r
 0o16Pedl1t9D4mPvJA6NVa7uXBfWPWE91qKLbkZ8Lpk0yyoyjMo7qO6hZ3pcximaP+w2Ik8O9uX
 5mSvPnRLF8igBkCYBTH9I71CoqWn4WCjpdVE9ox+d0jmzwMTV9FxRcea8xjs8x+FfWrCwx81gzT
 LJVFqCeNDPZY3CKyH/pKsLBUFFX/6cfzCoA==
X-Received: by 2002:a05:620a:458a:b0:93f:2ab9:72a0 with SMTP id
 af79cd13be357-93f57f944f7mr190560585a.70.1792546700065; 
 Tue, 20 Oct 2026 18:38:20 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:93f:2ab9:72a0 with SMTP id
 af79cd13be357-93f57f944f7mr190557485a.70.1792546699596; 
 Tue, 20 Oct 2026 18:38:19 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0aef8fsm22766655e9.0.2026.10.20.18.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:38:18 -0700 (PDT)
Message-ID: <d4498e40-47fa-437a-ba51-b97ebe23c3cf@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 03:38:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/21] include/qemu/typedefs: add GuestPhysBlockList
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-5-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212648.154493-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SqGit8FqmLbBvsXsEBZzY2PSjK7xAruW
X-Proofpoint-ORIG-GUID: SqGit8FqmLbBvsXsEBZzY2PSjK7xAruW
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad8178d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=g8dD7DYgvPE8XsXCFeQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfXzvqX2fUaExJX
 xY3qVmM7AJvSrid68b3LEy1sFUnFMX9oOtSwKk4tDSAJmgwrw3RZo7HAMmODEXBlujoY6vxMZqb
 nlkkukVsoL02jY6OjIqFcEDy4LonPhA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX9sheBYbKyHvH
 rVHuVJ2yhgyY57Na3j4mlmsg8si2hpesTXm0/pfE1+urxf+bK9Yusrr4pSxB/Ym10MOIxbzsMkS
 O8pYlS1mUBRYpFmxDkMwqDnURkMbl20ZdWvUhtrTeiT3m7zZbk69QmvQkWBlgHHy1Y+tSfW6EGq
 FmIuJijxy+FK2idP3qKG5Gl0mPMZEy2hGYxzcdfBmyDIrLqq/oRp+ros4HYChMkVwIJEUCZ5XBW
 mP5PtQX2BsGddm3bPOsgpCa7H8tYVOicKV6H9Pnwr4TL3Mp/5aoCDjJpSH1y4KYGWeOgdGpYb3d
 a5fafDVyhq3I8daE4h8ldrm3RBvUgZl8tRFFe4z6gS2na/I1VOrkuzeCcWHf/sI0lJeuKXERsng
 QZh41HjiUzICNcxFDu5ZTOt5eEN511NEzvxgupSHOJYB7ETQ5SaJsrftDhhxHKEimMVg9gqNHfA
 uEdbhFFgj6w8UkJU9IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210006
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

On 19/10/26 23:26, Pierrick Bouvier wrote:
> This allows to use a forward declaration instead of including
> system/memory_mapping.h.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/typedefs.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 8fa7f752dac..488d2556670 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -53,6 +53,7 @@ typedef struct Error Error;
>   typedef struct EventNotifier EventNotifier;
>   typedef struct FlatView FlatView;
>   typedef struct FWCfgState FWCfgState;
> +typedef struct GuestPhysBlockList GuestPhysBlockList;
>   typedef struct HostMemoryBackend HostMemoryBackend;
>   typedef struct I2CBus I2CBus;
>   typedef struct I2SCodec I2SCodec;

Remove it of "system/memory_mapping.h":

-- >8 --
diff --git a/include/system/memory_mapping.h 
b/include/system/memory_mapping.h
index 4c770bf0b83..3bdf9badb5c 100644
--- a/include/system/memory_mapping.h
+++ b/include/system/memory_mapping.h
@@ -36,10 +36,10 @@ typedef struct GuestPhysBlock {
  } GuestPhysBlock;

  /* point-in-time snapshot of guest-visible physical mappings */
-typedef struct GuestPhysBlockList {
+struct GuestPhysBlockList {
      unsigned num;
      QTAILQ_HEAD(, GuestPhysBlock) head;
-} GuestPhysBlockList;
+};

  /* The physical and virtual address in the memory mapping are 
contiguous. */
  typedef struct MemoryMapping {
---

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


