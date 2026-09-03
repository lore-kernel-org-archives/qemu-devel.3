Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F669C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sp-0006uc-Er; Thu, 03 Sep 2026 06:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sm-0006XD-8b
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sk-0006jP-JU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHB4D3203946
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lMpMDOZz/xhb8buMJRrQzEca60fKY7on9gIqwrt2+FM=; b=bggAhws6Rat5o87L
 OsBWXXaKgdLjd7QvLTMX70W7KaKS7S/hBpHEXPqlt2HeJ5oj95pHS2W7ANCtzZnD
 xzSRSzd5gDnvaveGuWflR5PW1D5Eg/yIDt20qprJK09kQSeBxU7IjDJ81sKd8yiV
 Ycvq46Zx9TSo60Rn3p8/Ftfc0yuOYKw0Yh5hTgN/IMM9wivMEd9W4u2Dt73BZr85
 AQHySFw8V7nzlWhJvaN5yquiEjJ0w0gA2T420mszL1HKcbI/6n82/EoHJ5Fyc1xQ
 MzMv11QjPe2Oym9swRZp6GKXbSvdkzDBwH3Zi0BBr1RzA3UxpjkP9UEua4zi2fza
 OwblhQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10ha4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ec3146553so614263385a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432080; x=1789036880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lMpMDOZz/xhb8buMJRrQzEca60fKY7on9gIqwrt2+FM=;
 b=e6HfEvlPS+joXIx3Ibqaxfxd7CE05gWx7yMJ0ihj4rQZBQyO1G/nZ8spvuMMnP+uoa
 jysA2ZnQWBT882s1LiQgai1LlgQ3Xd3NEYtEJO6FIPWWQZpujTwr0W2513hD4aUaUmGD
 AvrwtY4xPQT3C5ReyQro9gZs6idYiZC9wanpJ+IF2RDzpSnpSI/bdoA+xsOJwsuuzzHV
 aov29QkIkaEjAr7XfVrQaUWQg6i3EmdkXLMM+0/yWrCJxY3lyMdjmKUCCoeDmc1wpy6R
 8JEX6mjoYxbolV1HVZDQPpim7ULalvXNa0pbTdBTSOxSHK94aNT+0SXrvWuC8O7oBuxf
 2oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432080; x=1789036880;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lMpMDOZz/xhb8buMJRrQzEca60fKY7on9gIqwrt2+FM=;
 b=hlP8fWwARo3QjsqVZ/HGbTPNMXezRTztTm+5wTEIHgDkEAUNtl/dONSgdQTFdPehMJ
 ZKJdMcuAJjUTBGA8e4kEp75jlDyjc0/y+/5H5MvAB6vFcF72y/sAS/dY6goWsVrzzAvY
 hNYCxnv3EWtxPsB5B7y2hDqAq4R8BgKo/Eh4s5hJUNssNiMLcscryFzF7OfQeTXldtpU
 5kvivhGBzzz3yw2ecINXqE83jW6Eo84pYAfGWLaJORXRyeMp6ecg0f9YLfE53J8yqt3B
 Mz7r5JYwHA7GCsY6TGPn4K6WPWJhGiZxAbS6YAB+1AyEDJNzR/KE3r20zkZrCD1NyZL5
 hDpA==
X-Gm-Message-State: AFuF++kkCg+dTHpo7lXFKqXR5gw/YH4VQhh7Qxru108Gdn+C+vSCdM6q
 wkBsODT/sZW/KYOKdEpjnOjmShdG1FryUYqW96JHZNlujyer69saoabv/KeGsbNi8F1UYEjLpk7
 r/6jd1CKZCGhNU6paq+ESGBnOfaY4xsnI+Kr8UIBkjg7oc94QMNo/wr2agSiSn5cb+w==
X-Gm-Gg: AYBFou3ygNn4SfqtrgCRlDm8Vb2OdzrJE3S0h2ZlGHa+zZiIvJGmy/CtghZvYgDlpjN
 JNQ/WGNgtMQgJr8F4bkBR06AOXXmg+vnzjfuqbaJHOh8p64YdZI6VvgR9yYjpzJ789X+WACg06N
 ROzTgihhGNiEtQbZtHSCC0NV4r9xWmJRQh9bCJSi270ORjmwsK0QVjEs/BgUVVaSxsKYJgqNEDM
 mgsMgM8YfHsdAP2KQG477Vhni7/VS95Hjo3N/enUffEPOzGo00tupqjJbz93hijhX/TcHCp+Jol
 sPHY+Ah7GlGod9JDqUnshnX8DvPuUFvWHBH+NVwIfSFhUy/U77wAYAXpiLylVbBz2sIxgwv7771
 AwcOa/5ksSRBXuq+MtCFkmG3EFcXd8KDO5YUZizAh
X-Received: by 2002:a05:620a:6e88:10b0:939:5b7c:98a4 with SMTP id
 af79cd13be357-93960e0525dmr1032221385a.15.1788432080113; 
 Thu, 03 Sep 2026 03:41:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6e88:10b0:939:5b7c:98a4 with SMTP id
 af79cd13be357-93960e0525dmr1032217285a.15.1788432079664; 
 Thu, 03 Sep 2026 03:41:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cdbfbsm12872311f8f.33.2026.09.03.03.41.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/51] MAINTAINERS: Cover pflash QTest in pflash section
Date: Thu,  3 Sep 2026 12:38:58 +0200
Message-ID: <20260903103936.62355-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+TfnZQ9zL5UM
 5HOrP+JUdjq91DWclU06go0CsDn5UJ9VMbP8vty6eCDD4yRGZeKk+I3gxWRQIwMAisAuFSvYazg
 6IMHancBAlKkBLe7f2+LaWrImuYnfyPtwQu3u2J9zTHZPhsbXb+L8Ebiez9GTeFpQ9t82txHh8z
 C9fi3nN9FZpn8ynL6aA+aiFiAyBck5fPR7FyB0uGpnuJWUQIVNvSXjO3lGTycsqfKPHeqStxg0z
 GfaGLr223J0zP5sw3gqS07CedWIRxBlDGAPRMCri+U+cAbWa8vnpbAXemH/yHAb7vIuOfn0qICe
 Ia4Ubauw4dVYPEQ8wiN41/otFz3p0Ihp1cmXjAT0l9vw7bCumQ5CBdi0PwHO2h8ISFSCA79C3mA
 UOB/z3eU/0+aGeNEsSlHOV01rsl5sS04gTHu9G3lw75koydNFCJYjA5LYFDuhJjq/bAKtnoADAv
 89c3qPD4hACrP2lildQ==
X-Proofpoint-ORIG-GUID: 3luRI8iluCpt7ZqbAJ4TTg5ZHZ-2v66F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7QdrkUkIE2EM
 w114lsY7yjoU7Mr0vuzY6zbLDWo+3xx54B+VlG0zOZZYvf48yU7i3jYWa0m7S2l9GGWQlFNPXLM
 yNoyEw+tZ6hXKW63awmWCx6q4MCIJg0=
X-Proofpoint-GUID: 3luRI8iluCpt7ZqbAJ4TTg5ZHZ-2v66F
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994ed1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=S56xvJB5AAAA:8 a=tqVpZ52y12xuJfn1US0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

Include the pflash-cfi02-test.c test in the "Parallel NOR
Flash devices" to be notified when patches modify it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260820142212.27537-1-philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a898162cea5..e3f91ff1cab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2377,6 +2377,7 @@ M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
+F: tests/qtest/pflash-cfi02-test.c
 
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.53.0


