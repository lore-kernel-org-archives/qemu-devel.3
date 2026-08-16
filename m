Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5631FC5DF76
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAp-0004uK-4W; Sun, 16 Aug 2026 10:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9o-0003ov-Bb
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9m-0000pG-UF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlFNS3449940
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 78vNviaIAMo9FvczfotLXJJ4EhmR6DTr8heZBxnjUrA=; b=VJSw3syvGZeLh8+F
 6lxAMXIY4jXxs47KUL+z7OBj7dzLSvuIX4ZnD19Zjwd9YvPDqbxeMQBAClx9EMEl
 XiPDcIPA1IJvQRAkzytadp3juB+TbSGaGeNCYtYC7WawzW2IXsJibRn9V++a6+dy
 Yx4OwznCCwDwh7fDo1laonWxSSb7Z6PGSqC2IBcKS3zZfQedTBjSUtf+UgCjUFAp
 TduQCS12D7pii49Dhm4/AGA82MVfSXY8ZOgE4i5lWy9hysMNOEbm2HXf7PNVOny+
 IgkXQ8raONBuDTyjafSN6sVq3Y2AMVwJznjh86MrCUV2vQoeSxqFpxdWhAj70GFH
 YwNlgg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk3msk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d8243f1bcso26270561cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891693; x=1787496493; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=78vNviaIAMo9FvczfotLXJJ4EhmR6DTr8heZBxnjUrA=;
 b=Vi8lwx1QmYGTQh5131BgeMeqVJXHihk2f/zHi3xy0yamSa4+MJnlIOx38j9apDNR4m
 hi9Cq/OgmrHDdfw1/Fk2akbLVO9Xbtl9hXeqe0r2o9MzEfp9Hv2aq9sjNu9588bR+poI
 /dzoXBe6e+Mv1KndqIrwjDjlbbbzrc+NlihByEZsekPNAO/MEEtT5cjyyonAEYsCdh5W
 oy1xVIehRVfKCPVjpVtxNhEjenlnXyZRsYSSG8otP8il99KwtHPKd+EzLsd1Q7rebbgb
 mxosLSvyoRPgGxvs/1PZdSSsk4S/mUYR9NrwKqTrlQv8ppRLIUDWrgZelYCNZXC+qR8m
 ThZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891693; x=1787496493;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=78vNviaIAMo9FvczfotLXJJ4EhmR6DTr8heZBxnjUrA=;
 b=bNEXl7TXcvlPsWGbXbZPCjYGsdyM8w57rCz5/jGft6b5MvW3QPrEJahVnbHi9Z1OJ7
 RCsHIr+Y/2X6l51TEqDay755HnJ7BrIgGQelhuTi/wNJnIDEPP8pr8Bv8precfdX0LXw
 dlq/EtRu/ATlruq8jXa3EVNGCXHtLqImwZlJ2SD7NVmPDqs1dUHelFKvR0AswPvPSuvU
 wq1ICqr072/tPyMOBwr6ANnANQpJbyYoUwjie7DoeALCFkxmZhON52ihtgH6V0aHoOvf
 AIRt3mbJ0Lidq2xBgi2c0woOLWb3GApta+6QTZ9p1JlSlNVQ/tbEEvZV3Yotvbjll8Q3
 MUxg==
X-Gm-Message-State: AOJu0YwNoyJxVRk6xyeE640mQEvdVzWrCNsQV0YvunFpGZDGL8xAvv9V
 pyDVc4f5MPg7eY173Olnwhof1zi7vitKeEpM+uhDebX8PQCpAnt9f4bH6ZSmkbqy0j0tQA8HPMA
 hWKE2BAJUWLPFQBQzB/V7Kb6P/JnpkvNmOgkJMbSef7ttdbP6Qcz880SfrqtWqihH2Q==
X-Gm-Gg: AR+sD11Ga/u5tXU6NC9Eg7MVSqnE9U5RcOSjj+bTv0twMBTnXsrdFvkrRzkhb4ln43M
 HzXggnXBNy+Bmay7SgTSKUXGgFMOnBIPy6FIPsXgefIqO1tB4qD5WVfOq7DychDPjnfl1pkfmHe
 k9/HfgulybBkQvWDvSnQsUIpGu+VjPdU7AI2LcvM+amFwF017LrIVuBzx9HlqnQMtSbrxgHuh1W
 mBCx89q7DsENKNNh6gkiIZMLjYre9g/uA2BkDJ4smE5sum0e4c25aJylwRSZwZWObLDci4fSM+N
 P+ftx2ncS+yJX4JU7/JJyigMTmjsT/IP7Z7i6HTnYxb1+p/ao62k6dMFMVtxUVqfz01deCE0mE4
 ETtosAvEYhyzgT1fFDWfzu9+DcGuufz6mfXfHEAP9Dg==
X-Received: by 2002:ac8:5991:0:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-52d74a356eamr245378861cf.4.1786891693472; 
 Sun, 16 Aug 2026 07:48:13 -0700 (PDT)
X-Received: by 2002:ac8:5991:0:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-52d74a356eamr245378611cf.4.1786891693075; 
 Sun, 16 Aug 2026 07:48:13 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996176b8asm45651385e9.11.2026.08.16.07.48.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:48:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/56] hw/i386/pc: xen: reinstate the "xenfv" machine alias
Date: Sun, 16 Aug 2026 16:45:15 +0200
Message-ID: <20260816144556.69009-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX8GrLx0hCgD5Q
 JbuYL9ZL8SvoKJ1aKiQ2P20H62XXiMLrQPm+wQIeeAyjPDfoRCwZ5NqTo9bY+0pMiumtA0g7eU8
 8udmMEQ4gVPXE71SbGaAVgNYumutC9U=
X-Proofpoint-GUID: LyPLNaLWZxK_G-ZbRX_LOpyBdAo8ziio
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a81cdae cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=iox4zFpeAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VkxhiMxS3_JPjbmP7UUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX8USxbxIM2o/p
 1Mbp0PPe+c4cFoCmo+ERJJ2DbW8TSGHVrv2N8+tVUR+iQsnvoz3PgudwSP1paReaV8/eCsoxRPw
 LYG6OAMdOCNNbE3AreTqIW4KAcCfbMA51LYTrWSa3BgJGxsXZYpbWXKvJ78t3Wl4GALzPNLBa88
 jJMiGok7h+mGaMmTIljzwijZj8rMJNIArJVl4+Uksm102kVzG7HmQBHoTD8oIpPqsjzO+dzQtCY
 eggttQlfWolMLNbL+g8M3LjqdV9XbxLzw40FCCG4KCJDVttVEUnn7Hpq3w2yPNyFqjHqeIJIaAz
 ja1cIWj8269Keb0d/7r+Kz4mxDoF+gAXJ3h+/4wk1gpWk/6cEADfy863jhBIEizxQSlXYKYD3oE
 bRnAmYa0YNvXZLjTClKTzZ+tmQnYjpjSSF1lIX8pYKg1FHMaewqbSAXooeNNkkRNPmbBaMhj8W5
 FBosgwT1vG4EUjVsPCw==
X-Proofpoint-ORIG-GUID: LyPLNaLWZxK_G-ZbRX_LOpyBdAo8ziio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Dario Faggioli <dfaggioli@suse.com>

Commit 7d2778dea32a4924a469f1cc5767042c8f5b4eea ("hw/i386/pc:
Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines") removed
the Xen machine type that was providing the "xenfv" alias. As a
consequence, since the tools are apparently relying on such alias,
we're getting this, as soon as one tries to start a Xen (HVM) VM:

  qemu-system-i386: unsupported machine type: "xenfv"
  Use -machine help to list supported machines

Reinstate the alias and let it point to the only Xen machine we
still have.

Cc: qemu-stable@nongnu.org
Fixes: 7d2778dea3 Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines
Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260730162238.3308286-1-dfaggioli@suse.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/i386/pc_piix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 223a19cc4bb..a929cc4decd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -667,6 +667,7 @@ static void xenfv_machine_4_2_options(MachineClass *m)
 {
     pc_i440fx_machine_4_2_options(m);
     m->desc = "Xen Fully-virtualized PC";
+    m->alias = "xenfv";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
-- 
2.53.0


