Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4847C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcD4-0006EY-GG; Sun, 16 Aug 2026 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCw-0005wq-4J
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCs-0001qT-2A
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl09s3532565
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6mgJUWFqrEErrhAVCpUHLA6YxEppcaZB/77+pF0u2VE=; b=OHAyDwFLY0hf1uUJ
 v9YViDtddK6UZjRXhsA2DpuKthWuhV3RIclOETb9E+EZ+bQf0w34MXNzh0pYNKv/
 3OK5eF5GdGSdorfsg4fEPcSOuHddv97+S0/PMTxj78uTCySHl9VaWN3whLU4aFDs
 AhoW17RGtNLpgtgeu490Slz6zy0uyTk7jZtdg8h7hmzYIBoVqilhSqIfGVxQyydD
 WrdgpykxX9TkZ4E4+vMwQxXYbMXG1kqRHDjxzolUIFUtx6FSdiu4koWU0RDj4a4z
 XU7Y8exfZ/jEhelBfRI19p0wwqlpxnZWoyIdPa3yv+5QBpN40mPJF36j8WieRKhW
 8NmR6Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf3mn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f113592bf3so48883426d6.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891884; x=1787496684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6mgJUWFqrEErrhAVCpUHLA6YxEppcaZB/77+pF0u2VE=;
 b=FpOYhR8o4YhpYOSZ6XOX6rKZAGB5FEpt9iahFeQ1GlQvtRkjsI9CLmRtjDPoO+ghx0
 famMI1vKwfrSBII6jmr02kpdpZSdTRFsjGwc9VOuKpqTuGIQgrtazuf6UK6ZTAv5DRsl
 Q3m5dN4UH5nKPtUx/ULBV4HT6O9rfeEdlh/D2PEOk5P1C1y8IAKTZLuCAtJ4dlP3zHtT
 8CVT4lYynJOEK3g71NnbXzWXoESwfUf6Chu4rHdQukArFrYwHrRn5/OJWY3mp+4zqAmm
 IxXZDHEhX7BaFQ1G9tiX0UF1ZxS3pw3ZeekK86LwqpiDaSlGecxqPdAAFasyEj1R+lOF
 50NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891884; x=1787496684;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6mgJUWFqrEErrhAVCpUHLA6YxEppcaZB/77+pF0u2VE=;
 b=VhydAayw58tM4Tf9XsFiGl7wPHkbUnMwpwOySZ5WHTPEKZ+VxY/gkcpPfVmg0LRRqc
 xPkbKsnlfaX7Z/eGUwndifUBo3IVbiosKVyg3zoOa4fsm/q5d6t9RtQC+4fW8SvgwkXU
 LlKL2+Cva/pc2gVo3ptxlOQoJUPi8cSO5fDfQvhKLWkRTnDwGoMLhEsRuM8K5R4KdvOM
 5ggpc0ipAR1iRVcVrN/PeW1fT5zukBkI8PpFMpCdoXxqHkfuFuJsE/gH/3vm93RYUsJV
 wYQBLr8AVbh1UjbVoR34sFUJWcL9+kr1/ykqaJ/cnDt5apO1xqyatiWMbaDuqLxb6Kgj
 Y0dg==
X-Gm-Message-State: AOJu0YwqbKdISmXTKqzr5bcA1YSkzDzacb20RpCZOD34fYvaReFZSdHj
 h69ZFerMIswlZgKT/h2NZKbx/AKLWm6dCyzpBhyzz/N+XsfJjT48HJWDrij4C3qO2OPmQ5e5X03
 7cvHVgEcVMVBTGoKw4Gpi9w+pkv4Et52jRQaEeKBb2EoRkYgpOkjTfX2KsDXACmHYDw==
X-Gm-Gg: AR+sD11FlgakVyjhXESJ0xCV783m8zGa3Gsh7KPGNk/Aj2SYc6ih0K2r6A1klnzxlF5
 qhDG7gVg5KOaKoUGor5IG/dpYe6blfWLbM5bIORBnfAN/Iw2uA1i/b5n1o2uLDleQkvjaj2dpRL
 SlfMzX6rSt8lIfIWosgPKTldJgfS53Dq7AxJsSokPFGvOiFoE3OkYeycwDZ/XC88HEp3vKg0d7g
 0fXUttsO6DxKqc3xbuzyDdUV72UgSlrFWmupGW9EpVSL9COiTYOXcYGPLnCKckVZ7PhXNU8AA53
 RGtOlk1LyWa0nEdY/MgQCd0zWr6mbbxerhjmUjQGbDdFDoi2i5T3JpDqRqCTJty4DQeYDwfcZUH
 Ly+KPqJf7LMxnfa2Hb6n4xexKBQ/Sy4TBcQs6wybL/w==
X-Received: by 2002:a05:622a:1b92:b0:521:8ef0:b4e1 with SMTP id
 d75a77b69052e-52d854ad51amr204234811cf.29.1786891883923; 
 Sun, 16 Aug 2026 07:51:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1b92:b0:521:8ef0:b4e1 with SMTP id
 d75a77b69052e-52d854ad51amr204234421cf.29.1786891883468; 
 Sun, 16 Aug 2026 07:51:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499960988c6sm61459905e9.0.2026.08.16.07.51.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:51:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/56] net/vhost-vdpa: Include missing 'qemu/iov.h' header
Date: Sun, 16 Aug 2026 16:45:36 +0200
Message-ID: <20260816144556.69009-38-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a81ce6c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=yXvzFSThzUGNIxLvb4oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: qDppAZ-Fcj57CJ8ckq27n7hJJYaGRuo4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX7bt2ICYVBIdM
 mLFrrEbc2phNuZi6GTIKLcC398wsW/RofgAzT122t+Lfvr2Ixad+MxEcLQVim1GklARRWUsXxK5
 YIZG3XCaW0A30KSiBoTVaiD+Kqi6Mrt8A3Nz/96FcCsmMgOjEFFhXf00RpPQaLocX3oWS8Wgr7R
 bJ9zASE474Urmr5D0B+5CnNDlIo69s4hxgcA7Sh40ewXvYafaTKX7jA9AKBaPj+wKy3IVDK27bs
 HpWHmaaKDakv5aZLwuzVil4P7lvw8XRy2B9grrReiwOCj1F8Zw8p1EAeRfsfd7G3pm1/dAque1H
 +drqAdSx56VYv1ReByhUppHMMJ9AbLPQLRbBZtcnhKXxvj4lU21OKohpgFsdTktrw8t8Mm9W2I6
 U8cd76spdUS7tXQ/BWCY3Aqcuxwd5IcidtTFp+hpttrfdJGTkwwYVlERK0QqVFe1XhYJv6Z5pTI
 Qa/phVN43dBl2E3P6Jw==
X-Proofpoint-ORIG-GUID: qDppAZ-Fcj57CJ8ckq27n7hJJYaGRuo4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXzgm3U2MBFUWE
 17xZfSkx+tFk3n20QlN9ajsR09olNMKP0UU3Jlf9kcWt4NfuyBu+V2UgjdL9++P8IuO2scubsGO
 TBSAE4mATu4Ssjq3M9O9njCCLK6YYNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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

vhost-vdpa.c uses methods declared in the "qemu/iov." header.
Include it otherwise we get when refactoring unrelated headers:

  ../net/vhost-vdpa.c: In function ‘vhost_vdpa_net_load_cmd’:
  ../net/vhost-vdpa.c:714:24: error: implicit declaration of function ‘iov_size’
    714 |     size_t data_size = iov_size(data_sg, data_num), cmd_size;
        |                        ^~~~~~~~
  ../net/vhost-vdpa.c:714:24: error: nested extern declaration of ‘iov_size’
  ../net/vhost-vdpa.c:742:5: error: implicit declaration of function ‘iov_from_buf’
    742 |     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
        |     ^~~~~~~~~~~~
  ../net/vhost-vdpa.c:742:5: error: nested extern declaration of ‘iov_from_buf’
  ../net/vhost-vdpa.c:744:5: error: implicit declaration of function ‘iov_to_buf’
    744 |     iov_to_buf(data_sg, data_num, 0,
        |     ^~~~~~~~~~
  ../net/vhost-vdpa.c:744:5: error: nested extern declaration of ‘iov_to_buf’
  ../net/vhost-vdpa.c:748:5: error: implicit declaration of function ‘iov_copy’
    748 |     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
        |     ^~~~~~~~

Fixes: bd907ae4b00 ("vdpa: manual forward CVQ buffers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-3-philmd@oss.qualcomm.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c526c2b2dc0..1052361a4ab 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -17,6 +17,7 @@
 #include "hw/virtio/vhost-vdpa.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/iov.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "qemu/option.h"
-- 
2.53.0


