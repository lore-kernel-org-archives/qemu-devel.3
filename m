Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E044606A33B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lRDZWJRr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=blMvA0tl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT65c-0008QH-G2; Mon, 16 Nov 2026 18:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65Z-00089A-Dn
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:17 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65X-0000YB-O8
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:17 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNPoFR2053381
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G4TYzzee9B1nOFK8+dmvQY1U5E+j1wrRmxFUg4BPS9A=; b=lRDZWJRrx5dqrhr5
 96u65EORYkK9fbZLTYDozM4EPMmM2NRNNkuUxP238L2iNYmDWS6OPplCndiaWltG
 N9sTq6M7sEoFQHdeVzgIy6d7mc+m3UWCAltkdRdrziJ2MX+ib8Q07STpm5OOLzx9
 IThXY55+DVNimVdxkq+HhnXOJWw1I+4OC2gVMOZ/+1kfgup+S9mxAfNqc2Oe0Q+u
 c/W4EV0/p8/byyiD4Q4rAMo5GOGQCC1bTFhiksdgIvw/UlkG6MdmPvsnkk31RghX
 uX8hNY8nfJ+N7fHch/fDfDNNC9DwcjJCX+kF5OWtsAmvgls/mjECTDX5xWD8H1E5
 lLT1OQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgk096-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960bd17b5so283338485a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871573; x=1795476373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G4TYzzee9B1nOFK8+dmvQY1U5E+j1wrRmxFUg4BPS9A=;
 b=blMvA0tlgtERzw3cW3VsSE3EsqhfUddjBJ8Btwd2yW7S5zL8jBVfD2dH9kHrhmv4+k
 MO499wjM0BWCWoLx/dXGZtu1scCQLPcS63iMJVfcFieUFjJiAvlPXE+wiYD+EVtnVSIo
 u+plRO9FYhpJ9XuFjFBNAOVrBg14BD/4i7wV+GndXvWnrAf7xBGFPcemsxtYPUQqNKjc
 pkTx1PygEq4e8fqXHLILWidPkZZJbTDw8alXQW5gZH+XOJnCdq+iYZ1zqAPhOXM+riuH
 4Yth5W6/k/2w2Pu6KHwsNeASfK5pdstAJbyfqo/Utl8vX/ZcOpbm9JLYHX9zhJ5JWOYt
 /DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871573; x=1795476373;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G4TYzzee9B1nOFK8+dmvQY1U5E+j1wrRmxFUg4BPS9A=;
 b=Y8xRJAjZ5fC8B5/3WR4E/l35pteZODVnjKF5Yt1ZFckw9L+rFUSc8S6pLfQkRccP2Y
 jzRs7qi8w+rdHXJZNfFaYKjKKaC5PcmbIM0j3d26o30AsL7jG3t6ubdtJB0J+TJif1Mq
 qeMnHnvit+ZZmY2YwXA8+74ws4qf3P7JDVTq5OpPe7wYzBaHbhXgzMqfmrn8Jxkz+u/p
 64NB4E8EbZ15ka3SC6/bqlhJRT+R1Z8LcRJScGxz20m6w1R+Ip3Sha77Jj8XeWQujkah
 FpLPkOKYOVo04aAIPht9ffB+DMdS+Kda+Pb+XfCOPCDb3y2eLr+nkNO7zpkJu6QrTB4e
 XolA==
X-Gm-Message-State: APuU4Z84agAVnLF+rrkD2bh/pB4W4y4XQt78qiJ6Dpfn4eD9Ku5SnaFU
 oGKHQLfSHfLV+tepY8cCzoedO8oDYkW9lWO8wPptXEAWOolBHf9oTRZ+Iat2KuoyxkwiIucLvxH
 nm5haDPIBaexNCY2wL/yDhcZJ52nWGmHYI0mVk4cMhbb030EEKVv3y+V+BNCqiuHc+Q==
X-Gm-Gg: AYBFou2m6SbSdaG4Ci4VVMd1uI/gUyE/9bGSjVb1kIeHvj0e694umiVowU8AiRx5pji
 DDbruSSg0a0T9m3bt3HA2xljw8cpXCLsXBzqRUjAL4UAagamyHOrVOrsMAHhNzeeY4evGVvs/5Q
 rgojOeHS57QXnH7wMki8bIelZPqNawWtuhxI9v2AWB8WSCxp5uikhEHkEdR6rlShZEsHuUITfdp
 CSwslU2zAn9Kgk3d2SVgVOF7Z0rsQwZTriAhUB+KHf9AZjqqLLea7nV8aKeNWPQFxrvOynxKHnz
 PKu5VTF/cj/7zCzTXWXOBWvxdKBS4+OS4MrRWGNJ72Y/Dqb9i0i8k2b1FRJA4thStiBbg655i+0
 oLeyZav/+w7iD6Pa5vh6qcSqfSxHABsMvEPPHgEgC2JMGbFdWU/LTi/eA2Loy1Lk/AgJ4MeKWYk
 QAeyx2yM4Owg+Eug==
X-Received: by 2002:a05:620a:43a9:b0:949:3f0b:4cd5 with SMTP id
 af79cd13be357-9494bb88e29mr1898709985a.71.1794871573301; 
 Mon, 16 Nov 2026 15:26:13 -0800 (PST)
X-Received: by 2002:a05:620a:43a9:b0:949:3f0b:4cd5 with SMTP id
 af79cd13be357-9494bb88e29mr1898706785a.71.1794871572774; 
 Mon, 16 Nov 2026 15:26:12 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60da0a03sm19854000f8f.53.2026.11.16.15.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:26:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/22] hw/block/m25p80: fix write enable latch after WRSR2
Date: Tue, 17 Nov 2026 00:23:33 +0100
Message-ID: <20261116232335.31593-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXw2fZfesIt2DH
 DNFLjG84xgL0EWs6VWTjUkI+m0nJWmWlXLGnCBFacktaEI2gtyM3Y2OXOzjy0GLFHgAWDsi0yHV
 A3puJbqdOBLRjlrFK0wBaRO2AXcepRI=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb9116 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=Gk-RQn9YpY3vBVy3wx8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: QNyk6_BBxH_OBhDhwda4qrj76qcA-kTA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXxw5++RXpMOxa
 8Z3leF8AmJlW+2j1QnA8w8EHZZGww9VdSQe4ag15Ob+2O5i9A0SqR05OlP5TWr238lwCfSGrpk3
 uIuqhPDI6EafUuNBwEFNblo1Y8tLUBrGf/g+ZSQegTx4HFxy+Ec27Kv6tXclR5q9xz/ytAqwIIW
 LSBfDz5WzU+7R3fdSHx3pgNsfwrSfUU8p2p5LnWLcYs8pCA+bYhAXqxNvtVYq92ITpsBWFAffKj
 Hk0eRYZD3sNAfD4a6LvbqPvWDDg9rXDUrd3LaGKNvyNGB8NvY2a6g3bgMGb4OAr65jw82nn9HHS
 1BdYDWljKEbEg5Ip+oVSPJ2mmne9Z1WSAwQhq0/DhqUvM6R2rCDomzAFdWKIB/2/8vT33oGNSsj
 EVL71dKpSbo5G5NIuzdBLKZHLLAUkrH2ij+d+OTiq3FuSFiXVdqtlky+kxzkKFI0Sp8MiA4tnDg
 fjnJemWOMfxCt3kT4fA==
X-Proofpoint-GUID: QNyk6_BBxH_OBhDhwda4qrj76qcA-kTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

The flash clears the write enable latch when a WRSR2 command completes,
just like a WRSR write; otherwise a following program or erase could
proceed without a new WREN.

Fixes: 9785731ec4f7 ("hw/block:m25p80: Support write status register 2 command (0x31) for w25q01jvq")
Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
Message-ID: <0c80a9c01452a8695b46a6d9fa920f9a14f4de47.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
[PMD: Directly assign @write_enable]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/m25p80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index baf798c6b5cc..92e67fdc5e04 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -840,6 +840,7 @@ static void complete_collecting_data(Flash *s)
         default:
             break;
         }
+        s->write_enable = false;
         break;
     case BRWR:
     case EXTEND_ADDR_WRITE:
-- 
2.55.0


