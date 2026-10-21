Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04000606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b2WMk5P6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q7+1bmHA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLGj-0006MF-PT; Tue, 20 Oct 2026 21:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLGi-0006Ly-8l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:37:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLGg-0003Hm-Ja
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:37:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKts5o2795769
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FQ0sWJx+wKrXlf/r0XQ7AVwOqe24Pw19zJu7PUkchl0=; b=b2WMk5P66UB8bwke
 evyEqrmRshMVubYWGdrw4tkZ+zk+vdE47sY1ULTScV2ASpr9Sh61A9eMOHgG+Xs6
 IK82ghkrUBajTV+6c38wdzj3zXiSYfR/ukytjRAyJSwnBUqVWiLuHE74YJOBHDnK
 XPXxRQ7+qHXCFGrhx7jzQiv77GSZR08em411uFYWzJ8icIYYt282laDJIXhLD1ZH
 sSuU012+LRCCcPZBLHXpBfM7fFvxWAM6jVxDBAmvva9o6oECRmROg0fGRIPJWP9+
 rfBmwQXeqYNUangEcoBy66t/+hb4GX3FNae8Ta4zigFKv4jGbWlCjdMf1nYg6OoN
 Xl8Mlw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2axjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:37:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf7856ffso62217385a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792546644; x=1793151444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FQ0sWJx+wKrXlf/r0XQ7AVwOqe24Pw19zJu7PUkchl0=;
 b=Q7+1bmHAFwpurjPj52WsdUo2lDrw0KwUfI4zxDd9t3JZKAdzG4D7vxYUxdO5HCKS7z
 cou56YTZSBr1Ci1l7fUps5XKW+JX/yK/S03gvTNZ7trbN/9MW4XsyVCqjJONgD+nbbLM
 e8nVbtO55UF3F4nydTCqA6DAn+FroF2LRfVr4ruiedxRyYFBqL/hAQfad8+7zHWkBPPT
 /M0ghvrLP1YVp2CNEKbR8FYc1UN02v3UWqtZjVOIr4jEGy2pH7JMrzOnIuj12uUWm2W9
 /B2tRAAr/IuHfkWMHAP8lFYT9dLobeYRqDLKmxbCc7D5ZcbhHnEz0kk1DzDYpDnnlfbf
 UEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792546644; x=1793151444;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FQ0sWJx+wKrXlf/r0XQ7AVwOqe24Pw19zJu7PUkchl0=;
 b=1x87gkIVHjxuxUZLbv5PniESS9LhxkCV8yMwokqPj2kCEG0Qtf5SfPNTywE0G0MOiM
 ODiBgbfptHHk2ofQ1wrkdLWXJC0Qj6tAl9m6//rt/komTbhsJV/E2ode/OyL80r+ThZr
 O8gFtw2/s0CkTOtbuJ02y/sQ4mLBmpumD/0v9VbbnMctgeQYbsQrc6MOnnlUU2n62KTa
 ngPkJezvBUmXU57oQ+tWXsdIvpcxaX6bdIlcKydAO5VsTty0eBf+uwKGNWZqlkfHYwW/
 la9reishHIKPVMfZyfjNSUNlfwLTnMDrU+lm6uJy6hsgh3ri9LqUOD4ONuZzfYIugT4k
 pPVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4GM4643aSGcplxXjKJt6LvQR/WGPXJbUYTM7ccP4hUy1aS6rkBoDspE6P7vyFJFj0/n0pN9/CEggO@nongnu.org
X-Gm-Message-State: AFq9FYKdlTOyXq5woniKoe2SL2PbN4MZM8wLggYkPNKZ70TmvKrQgZ9k
 mVWLYFT/4zobP+0j004HhqJrHnsrrkuOpp5FS3hrJor676rI2hnQtrQyLN0XKuL2AnrDgeu4aL6
 EuzXbH3ZvXJtBzUuSFQYSPakvJqh0ayLm94tbHOKkwowe8oJlHRsIB1c9ug==
X-Gm-Gg: AYBFou2hNWhjlmXbDlzK5tpSBbGI4eFIc9qN/MBVEO93bpCMHbEW8KVtqPdzcxwL4GN
 blKpN72rAWhzT8OG5c2tVHxBEBSUvvBdaXpC8Oev5E7gEsKCls1byLOApskNFmoYUmD5Ps1X+b9
 h2RuO0q8tRFc0NxU4ALsU/TkXCijDbJDtOPYYRk8j6mpBdNzzMsGclewgxGyp5tuR6BwuG3hWd8
 re5jWnNBjZ+pVglnAbIrIpsaxZVmsn9QgxUP6Dn4dnwkdq7YsmvCYQc3HqL9beIxuBC2p5qRKh9
 HPyGPvJoYco+mn579OsySrGMST2is+YFUieohfj55XtXWoaoNRX3ral1+8iNi9y3QDbJdmhwYxi
 nPe177PwR9JKYT4kdEWtYv2pXDniB+9Wb6w==
X-Received: by 2002:a05:620a:6887:b0:93e:6c4f:bdf1 with SMTP id
 af79cd13be357-93f57f6fbfamr182556685a.17.1792546643983; 
 Tue, 20 Oct 2026 18:37:23 -0700 (PDT)
X-Received: by 2002:a05:620a:6887:b0:93e:6c4f:bdf1 with SMTP id
 af79cd13be357-93f57f6fbfamr182554285a.17.1792546643463; 
 Tue, 20 Oct 2026 18:37:23 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583523asm2026682f8f.37.2026.10.20.18.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:37:22 -0700 (PDT)
Message-ID: <0e39bf94-100c-476f-86c3-96bf86625c53@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 03:37:21 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/21] include/qemu/typedefs: add ArchDumpInfo
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212648.154493-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ol7c2jXtCitpMqeJKUe3-UYuzXNgDEQM
X-Proofpoint-ORIG-GUID: ol7c2jXtCitpMqeJKUe3-UYuzXNgDEQM
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad81755 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=g8dD7DYgvPE8XsXCFeQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX8PbHs/bGc/+T
 V7k6112MEJ6mKU83N9NS+zokcSRMtDzqqT4uzYngcexlRcldvVCojqHIgmJ8qJ+8YSusVG+IAqd
 84laapReb9A+D+OtqWF1oA1abXWiZjA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfXxzfgwfSz/8pn
 +YyCrs2Z17KRR/r/oIto21Lo0f7IGekrRIvnFV2EGe8YoYliqORMTzc5GVlD+nyarj6RnmibUv8
 fnGU0R+S2almDcld+RAzFq+qpxWt4h0PQIu5OFI9LyOu5ODT8cJFGMHm+h+gGlOyxRi/ldzPj/X
 jNI/hEPZ7+5P/4cejYS2YZc96abPa23B+2EkhsO8Um6tpPWtm8IMYG1xbFAHS57Sijs5DUcWmxP
 fTtnZ7mTEGBq0XEF+SztB9BkbDBSLnis9ZU/Rd9rZuXkluAP5DLkUCGf8zayFCoVqH7PnsNqYzs
 DzxuW8sPNBQt2r4bYGC3qI2MbHVR5NjfRwffn34vxYh6mr9Cy3pYb2SCTMGimYsrjexwZyRC7Oz
 rKzjAxZwQvV6M+1g6COe9RumVkWqQf5xf9P3u8cn0nfkXRURsQQbo4hR2vx18Ov/O6GvHS6z0/O
 e0JEIZ73CzQ8llzHsoA==
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
> system/dump-arch.h.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/typedefs.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 2344c92182e..8fa7f752dac 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -28,6 +28,7 @@ typedef struct AddressSpace AddressSpace;
>   typedef struct AioContext AioContext;
>   typedef struct Aml Aml;
>   typedef struct ArchCPU ArchCPU;
> +typedef struct ArchDumpInfo ArchDumpInfo;
>   typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
>   typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
>   typedef struct BlockBackend BlockBackend;

Remove it of "system/dump-arch.h":

-- >8 --
diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 743916e46ca..7165a5bbd03 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -14,7 +14,7 @@
  #ifndef DUMP_ARCH_H
  #define DUMP_ARCH_H

-typedef struct ArchDumpInfo {
+struct ArchDumpInfo {
      int d_machine;           /* Architecture */
      int d_endian;            /* ELFDATA2LSB or ELFDATA2MSB */
      int d_class;             /* ELFCLASS32 or ELFCLASS64 */
@@ -25,7 +25,7 @@ typedef struct ArchDumpInfo {
      uint64_t (*arch_sections_write_hdr_fn)(DumpState *s, uint8_t *buff);
      int (*arch_sections_write_fn)(DumpState *s, uint8_t *buff);
      void (*arch_cleanup_fn)(DumpState *s);
-} ArchDumpInfo;
+};

  struct GuestPhysBlockList; /* memory_mapping.h */
  int cpu_get_dump_info(ArchDumpInfo *info,
---

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


