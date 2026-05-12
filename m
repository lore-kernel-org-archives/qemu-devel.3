Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA34CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrsr-0001I0-BT; Tue, 12 May 2026 14:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsU-0001C0-CH
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsR-00016l-KZ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CEYYkd1733310
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SVMB1nXKAkQazIjPh8QpcWyMAuQ6wp09vFCO3lv4GXo=; b=IlS5qNDG2HB0exq2
 ziAFb92pemGY2rDpqwLVXUu5qNI/d9Su+cEDVaH+DNxB+/sOGYC3uJpeaFWVU7KT
 Po/oe331WhXHQKpQqDK/bCJX7ugeZcP4QHiwL9pe37HLeTdtyGu2HsVxw+wt+jO1
 YUBLVB9py+eH0bD5s5q5wq5n+O/VzkNxFGZPX8wiUpIQh9OysFqLPtZ5DqxchXbl
 OFQEuEhLwvC3pmTSkvMaOw2Gv+yICjbSKf/Yp5kyxZhRFaIM7R7nd0Jyoso4civp
 Jek0lZU5rwin77OQ6ivJJqCPDC9FYx/SbR5fngi6+zrIGgE1F3Ndm75Iq95EhQM4
 DSvRcQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463dgxyp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f2d983d109so8050525eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778610641; x=1779215441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVMB1nXKAkQazIjPh8QpcWyMAuQ6wp09vFCO3lv4GXo=;
 b=PLH8h4zODZh879x+rx4++050l8lFTjgp0VH7MYOgBAyicfxZJq+eYvxacL8uLOt4gO
 8TPWcCaBoqBwAfk7aSWzubF8sNVqXE0PbNGwFcKRShnG0r+8lrxMYhhS0Si7ynEYQjKj
 /N//dc9qkL547MGs01VASnKhRgk5rqV/FAPhoV4vMopLp4xuO1WALxkD7MLSdnYtIm7k
 c7ow5lGZOD/4cJRK9YunHgE7WqYSoLUPKiq7ADmd8v6jQdAR6DJ8Z9VsveItpMrbmQqa
 xE1xCgOnzga/nYtGJDJ9Hz0Q7ybu+N4XxqnwUJzDUJch7AZob251OSwpqzPs/1mCMbzr
 Dmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610641; x=1779215441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SVMB1nXKAkQazIjPh8QpcWyMAuQ6wp09vFCO3lv4GXo=;
 b=VuP5UwHy5qNtVtLrabHICeU/R2stYYLlW5V+QlYXQrnsJdPXVIVVkF8OiauTz6MYrK
 ns95uvJ6QHj8Wo96hK28kJKXsO9dO0pWJNrONBZqsFeI5wzp4RNmmf8H82j1gICphTzI
 QxYaNN+/sp2/ANUDyA93tjzXEGFyNIrZgXvPCtKhzHLQc1Nu2Nw9gJWClu3n7gsc/ZGP
 BPJDkK0YFwqVphwd6XRSc4z9DTvcZTDjcQ7Nd8Tx9YwiaZLpf/7g07xUdCqJ3z7AYyu+
 9UDUSItHRE5Bx9O5h3Q+49Wh/nH7gJrm3yhbASDpz8SSWCfQN/wMCOAmmxW9VefMGWqo
 sshA==
X-Gm-Message-State: AOJu0YzxMYX2NCJe1t2Fs1FpuyFCZmt+UxASv4Or9Wx6dY0Yn1nZ3cq5
 w9c1ZUrgT3zy1GzvYu6zMy9E8wMBOQL9IrrYaAx5uOKtZNGYch7YGDOeE6ojmnvs00ptPAz1cXv
 vGE4pLWULX24SKBc0qIZzf5GLtoqxvV+DsM8iyfQrl2ZsGGx8lBE3X8zbflmCvBA+g1go
X-Gm-Gg: Acq92OHY9Q/hU77om4Jt7TY0HgNnq2LhaELjny3BXR8W4VY5KIc/3oanh00jikK3fiT
 KG1aYu4B46hmoD2DZNkVkGcDJRgD6ugWCMWOR1LYMAQxdl6VtVC/P88/7ZVgh0c00DjNOB7MHDE
 a/XLzPIC2iSOZqxi3sjvcmmoqPbWi8sogHXTALU8q69HCao9j7YOeY+4WZ2DFkzk5vOOshrEOP8
 bkS8InXuirikG7v/X+PYlwN89JjJ6Zk7mYwxqC+WQHUXNrzP0IiaWokT5hdRVU+uBfzxiu7IZKr
 XobnMFDp+o3vylqwKKzi/GJ+9g3VCixrLwUnRV+9mjaNVTQwbyt7LAuQeZMFHxKeaj4v0d7O3LW
 FxXwNu9NbbAd4RkY944UPCozcfcezgGNZ7rk/O3eRQRLbiEViLfr4N0X9YToNBhAutKZ7LSzrZZ
 Uq6O6Hsg==
X-Received: by 2002:a05:7022:30b:b0:12d:de3e:86a9 with SMTP id
 a92af1059eb24-13436bb3cc1mr49018c88.39.1778610640658; 
 Tue, 12 May 2026 11:30:40 -0700 (PDT)
X-Received: by 2002:a05:7022:30b:b0:12d:de3e:86a9 with SMTP id
 a92af1059eb24-13436bb3cc1mr48992c88.39.1778610640053; 
 Tue, 12 May 2026 11:30:40 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm25221376c88.11.2026.05.12.11.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:30:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/5] qom/object: register OBJECT and INTERFACE QOM types before
 main
Date: Tue, 12 May 2026 11:30:26 -0700
Message-ID: <20260512183030.1431103-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gTadmPz-4rsUXOQlO9WJiQdqZOFME6CS
X-Proofpoint-ORIG-GUID: gTadmPz-4rsUXOQlO9WJiQdqZOFME6CS
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a0371d1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=TGpnWNUbWJQoO7jwSJQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5MSBTYWx0ZWRfX2ufSTebkGAVd
 x6GRgeaO7H+OYt71tUz5B+Y17AKPLkS6bm5wyIoeab0dtwqWBGDUvPUWECNqnXl9nkWDThoc7KB
 pboAddrTwhxh3lyqok134lFHHfHyYo/EijyIlbWrwF3/rpyWjGUqZ2FBEPdjo/PQIGcDx83p4Ui
 xavnM7Vb52pN9efzjYtU8X+tgqnB2kfVu4D+qcwygX0LJS7wYwGtNUhm4YUZL5e8uQ73rpr6V65
 339uWZVWiYftTi0JOLp4llXifRijxmj8tJyPbdVmVbEv5cU/8TKDKWAGeZKyLYJZp8gjsZN0ZEK
 ZrlOqcXesNMMKxbOwIhtR/jQr+58/0srmV0XhodFdzF7nPf3fURBLm0qkwBDsaREkQJhDxhOpEI
 1mLKArJ9aDqP1Zju+BPhGSVPQr0hD5aCBgdl0XbuBad7Xh2H+985Waebob2zMIrRCpBxhD0CJRl
 YDghQiaCT4+Xcd31/sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120191
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

Those types are special, as they are the base of all other QOM types. In
next commit, we'll introduce an extra step in module initialization for
target-info-* types.

However, those types depend on TYPE_OBJECT, which is only registered
at MODULE_INIT_QOM step.

To avoid having to introduce another step, and modify all code calling
module_call_init(MODULE_INIT_QOM), we simply register those base types
directly in the static constructor, before anything else.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 59fd79738d2..b82b65a3a18 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2844,7 +2844,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
                                   NULL);
 }
 
-static void register_types(void)
+static void __attribute__((constructor)) register_types(void)
 {
     static const TypeInfo interface_info = {
         .name = TYPE_INTERFACE,
@@ -2862,5 +2862,3 @@ static void register_types(void)
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-
-type_init(register_types)
-- 
2.43.0


