Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1B1C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4hAO-0001cV-6i; Thu, 10 Sep 2026 11:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4hAE-0001bw-Oj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:58:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4hAB-0002lE-TH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:58:14 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF4kwa1652845
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OPTjfya0LFf2qCHyAL0SFvTX
 Ep2n1zeZrZKQw3Z5r+s=; b=VeC3zPMfncneABeCnfZQt5S332Mqo+MUg8iNdivJ
 jJPS4tqXhKyQ2Otu27ZvmGNwZSZ/yjIoWVL7jj1Ls3yTHOB8uCL5/zIpZy0XHhQQ
 E1ukMbBRL0nptOWxn5qWqNDDHBHMZae77VIVpUmoZRBkSPs7zd3Oc/fGaHTHWE1T
 MFKwCCCoFKfqb4kyMYIhYQeY/HgEEdsmP9C+91v6YrAF3vEMAtQByrHFVx/XGBtF
 w1TdRi6xDl01x4IFmdpqZtiHfSBdywy64xkRk0rKTeDWNlFo4An273iNmUKK/Zfs
 U6Koe8GyfUu5cPULMWHHuLYa1eqKOAZn2EM04zXqJ6rdtw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrcjt95s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:58:03 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c833d4bd04so488348e0c.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789055882; x=1789660682; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OPTjfya0LFf2qCHyAL0SFvTXEp2n1zeZrZKQw3Z5r+s=;
 b=FfYc1d3hFH+EX1ltN/zV2GZyIC/dgTb3fdGHkYbjEl8Y8yr0lmNWDdD+Sws8X/9/1H
 WV+Ns8El18FDEdfGVB4bKZIPYvwNTuVGheW7ARY8LM+j8TnU2QXYUyVkVLM/Adkizsgx
 6w3bvdMQ1lAgdLx41E9dRYSFojTDGn7JpDZ8KvYIxaSwb/TAb5korZPlR/Ov/P7HkqM0
 QqtZW51gZx7awqHO54rNxYkNFZaKY5ZudKQUm3SNa6NWYSCm2RdjlVoLXK0tPWo5mUmE
 jzBqNEsj7J62ZQ6RpT/I1qa3Ivir8GiUO18qIflxdQfAxBjQOFn8ygOV8q4VBUhP+X6r
 alEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789055882; x=1789660682;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OPTjfya0LFf2qCHyAL0SFvTXEp2n1zeZrZKQw3Z5r+s=;
 b=fNq4/w9B+H4KPekpLEgUU+n6uCXFcRlibVHQFlXKbEPN5B96ydvmVFpi31h/2hOHls
 CzgFxYDGJY7r7aIP+gijn5ggdGEXTbVWTbKYfsgPXwoWDjbprzPM0O2/e0gPUKIydOU8
 Ed4drQOcpwetS+nc8YSgyV6Ll2NYxIjQQ/y9QtTOhMEHPr591PYe1pWrYrT1YR712gD7
 W03jmGsbm8kPouD7FpYjcpeBEDkl0kfxA+3lmUnS8tRExe0aTil0LeRePGo4x8kidLj3
 VTCytS0HVGfQzuFi4B0KTOzvbz7ZNnkKwrTLyt3vaTnYSDPUVzAGtiUOe/o9b9gUAlnl
 AxUg==
X-Gm-Message-State: AFuF++mHPoqikZhOcS0a7YYsSBDNlW0N6TgoW4CEr5/GwFa6FAsMveZD
 KeS/3MknkM5RfB67e31TCtG5M7JF/8VL7GhwpD6YwM96u7JQi34LSzBEUaxF6bX5sCkgXvmJLsO
 ennsMibNxb/dG0qbcRWLBEg3l9cAY7p6RculCPdeb4GE9ttkU5jPs0C15xw==
X-Gm-Gg: AYBFou3AYaTcfeWltj678I3x/Kx4d6xXg8+C/UoSAbjh7FB4sqcFMbDTBPFkF5440PW
 rJAxcgLl49r5DaU56xB07ZfvQw8XuebRAsQIIvP4epSKk47wCqSgFeRyAng25+sPxsVE+koLRY8
 ncqzOiROPPEx5n2AFrXAxvPIkvIVmwEtKHystwMpD+LQ0L6zycd05YBQ0hSHimQesNo2kqEpIm6
 aF1baGXazKVPZprfdST8hupa9HdCmX7UEcooku4U9XvAkMzeQPI6KMY2EBTu0jx8JP5kTHEKZEg
 5YajqvHPfAm5WqElMABZsHYXGgY9d9R9ArEcQNwFeuyPKeC82RJHxhfXr05Q9JktSIHhfdM8C5l
 c8ZqjE+uUAgWFI82Sv4ebOiEru9on+OJWHKe3Xw==
X-Received: by 2002:a05:6122:4f8c:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5c845d83f7amr307404e0c.0.1789055882579; 
 Thu, 10 Sep 2026 08:58:02 -0700 (PDT)
X-Received: by 2002:a05:6122:4f8c:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5c845d83f7amr307316e0c.0.1789055882047; 
 Thu, 10 Sep 2026 08:58:02 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm79683545e9.2.2026.09.10.08.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:58:01 -0700 (PDT)
Date: Thu, 10 Sep 2026 17:58:00 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Sunil V L <sunilvl@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v11 5/5] docs: add riscv-server-ref.rst
Message-ID: <fmojfqv4gzejcpme5ksfephezhl7xtd6wwky3zsklctf24juh2@237hdphoupo4>
References: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
 <20260909210756.1767711-6-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909210756.1767711-6-daniel.barboza@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NCBTYWx0ZWRfX2CMzhZn3Dawu
 Wzl7SrMDW0laKq5xB/VtW/VoteqouP7q1zSOh7eFvTFW5wIO/e0EIrk0v5p8MOjyNw/krg2yUMB
 dmtkJoq7YWsH2CixX0iJzE1XfCfKoYs=
X-Proofpoint-GUID: UChELuey_324_Mzw0Y6F3dPKrgJUvJSA
X-Authority-Analysis: v=2.4 cv=aef0Dhot c=1 sm=1 tr=0 ts=6aa2d38b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=INa3_cfVNqtrqgI7vrcA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NCBTYWx0ZWRfX8mej9yPBbLvS
 trx4SI8N2eE/0jX3ecD/sPrhXprfroGQuvFQ04fuWwzAsYXQuKcjKGH2pgCHmETOKC9P1GX6MOn
 F8bW+aZi6QlPcWbsWonSXi2scEGaX2KvN3XkcWKhMlWJy6mFzUqNUltPhVEgxalTQM/2DJreLPW
 VzkgaW8M3BSxWgs3JZ8izfGdWfbkFyFfCgafyqrfxKyEJsHhOB3q6vcAagL6/hEc6FnepWS1OOH
 o3b6kk+Gyfv7v/w7dvihaN0kHeKT4yTLcMlbL6jvVIPL2ToBlM/4oQY5CXSizKbYL2DDmFo+mLZ
 Rd73V30aMU2GK3fAVie+Bk6qFiO2gamw01zkD0+ZpQqv7ZJI/RgH6x0du+T1exykHsQmjOcyx36
 xbqdd9f7yFlsYWHwczC1BGIhp1/a5ft+Pfebw5ug/osXt/vnz21XPN3RPonhcKAPbtPPVUZ1k/+
 1lXOjYHjTwtcoCKPVxQ==
X-Proofpoint-ORIG-GUID: UChELuey_324_Mzw0Y6F3dPKrgJUvJSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100194
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 09, 2026 at 06:07:55PM -0300, Daniel Henrique Barboza wrote:
...
> +     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
> +     -device ahci,id=ahci \
> +     -device ide-hd,drive=hd0,bus=ahci.0 \

The image is named nvme_disk.ext2 but is attached as an AHCI IDE disk. If the
default AHCI controller is removed as suggested in 3/5, please update the
feature list and use an explicit NVMe device here, for example

     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
     -device nvme,drive=hd0,serial=ddaaddaa \

The documentation should also state that the base machine has no default
storage controller or NIC.

Also, checkpatch reports that the new documentation file is not covered by
MAINTAINERS.

Thanks,
drew

