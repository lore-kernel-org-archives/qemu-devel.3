Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08162CD98D2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 00:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdhc-00026G-Om; Tue, 16 Jun 2026 20:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdhJ-00021m-Aj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 20:00:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdhG-00085J-AB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 20:00:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLSune274532
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OQFU1HE/Rsf
 wQU6jI7sPub53aSy2639W49+DYPI7GX4=; b=OUi4D+yICeet5SWqNMpfqWK+kXE
 5m04kuuaYEKqrigImojdzUd5naGTdNQ/yXsIBcQ+YOrBTFIeqlkmmA8uO3TDiNzI
 hc4LxWHOfe/RhmmgqEAzwOES+UfHCZd7ssveHA3nSuP1tKmWqgivoGOaOxD6B0Z6
 vdhVeGCKncEfhDvOK9NbxG7HSMEsLiI0/b++jnAnde+ms1WQ1Eo1XMW/LESCB4NF
 e1x1UHSgUrByrEDmHE7P4w4yAakO0IO4EY2fiH38QowxUOBWYcN7JQr5hfSV0pxO
 FW8RX9PWnRr8acWxeIg6rSGahjXsd4ktPX8VxWj/mtP0ZU2BDDvPC8BgO6A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueemgdmu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cceb0317b3so78759056d6.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781654395; x=1782259195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQFU1HE/RsfwQU6jI7sPub53aSy2639W49+DYPI7GX4=;
 b=MdDtXDsyrOArFq4qJbRc1nQ5pR1M55G5j1ouGaLZa+gUiD9vCzzVCgugOSYeo8IrT9
 ApeWvLt9S9XwwF0krWFCY50NEUsa4GqIqAfrdKHYJEM5igrS3zQWtuB+5TMExuLktFf6
 eAj6zbQXYa4pq8rmXCy/calFWxHU8MTvfsle7ITQo+ABPS6WT/eIT6s+g83dICFT6PFM
 zC03soy9hJ3P4frVTU5YT+U3IL1hQ8yqVpVVYhDuke98AiUoF0bhQ3UKASHychnByz46
 Vnof+B/NIELrRnikQ+02Y0IPuzxboy2wMKvXw9LFV+Yral5WMa15nTZgE58xcH3OM/Vs
 8nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654395; x=1782259195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OQFU1HE/RsfwQU6jI7sPub53aSy2639W49+DYPI7GX4=;
 b=Mmj/uFYgzlf9j+T9XFeHoKy2C4CZWP0zBHgiaWrow0ISrqLkzaIKe9/4+zcF3TXLhv
 J65Qm1f45GJIVukJx42n9ywM+eF1vxQ1vYwgFyCboNd5349nzmmcOs4FSp68BkNRmp99
 jDncOlaxy0sZ0myKS0XgHu5dWX/C7bw9nsc0b6ki4axeKW+fSopzGXRXQ4WGSLOtn3MB
 8o9gSGQtBnOlXKrO9yjX3qqWDVGdrZw02C+7DEVsEcGcZFdWAXfJ3R1OJRdmwvsLN8EJ
 Js56WFNPy3pkjYSWvpKGSc1IhkSUE2ixe1gbdyDVE1CKMNw6UAquFNffY4kMhSYA+Icv
 OvNA==
X-Gm-Message-State: AOJu0YyIp57Ddj8jvG0yTE8mIdnJqn13N62zT8o4eTc+lwLqjkcTxrqx
 BosripgDa+T5PWw8LOuhT0u/Qp4B+S5V3FDkvkwZfcYg4/jETVpVtZLZdhB820/SG0kqvIXzt3o
 13kTiktBvCRBDWndFdOpsvlGBPHYv4K9bG9R6HGNy7iQutik0VsoSa/utf3ZfuV4Q+g==
X-Gm-Gg: AfdE7cmiQjTC2R3Ke8y7Q8jKHndiFiHVNt5aIGWm2piiv87s2OM+/vITuqcsGKqJ/fE
 sYii9y44fo77lMYTCog8ag6Gh1lUV+46+AN9vSyZ0fH3UOL+qI6wJs5pjxJPTgAObPlNGD3XE48
 8YNzPcCHA1avk2iyyHQ/ybpMCtVgKktNpjjr+5tbElrXUf3aivqrQyl/OmSQCbfXI9fDThIt7kP
 HX1yLT5zVsTJ8X5nzZvpGpv8R/I49+XbVw6SLT0GCJJ1/8bIw5p9grrSaiVOa7Err8FexegHfd2
 eIuVIQtTplcvGjtP5kQnKyDy7SXm4sCDIoCOaNtE5OERANtuwJm7gE8UwYOe3ZnA8Or4HQo6AS/
 jP8fCbtDyeraA3tSkfupB6QtEApXiqtxruvv47xDMkRRP+hHhYssB9RLI6Ao=
X-Received: by 2002:a05:6214:3314:b0:8ce:ba1c:eb74 with SMTP id
 6a1803df08f44-8db5ab0e921mr27890876d6.14.1781654395054; 
 Tue, 16 Jun 2026 16:59:55 -0700 (PDT)
X-Received: by 2002:a05:6214:3314:b0:8ce:ba1c:eb74 with SMTP id
 6a1803df08f44-8db5ab0e921mr27890646d6.14.1781654394678; 
 Tue, 16 Jun 2026 16:59:54 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f132178csm50191986d6.7.2026.06.16.16.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 16:59:54 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 4/5] hw/riscv/virt.c: change 'plic' nodename to
 'interrupt-controller'
Date: Tue, 16 Jun 2026 20:59:38 -0300
Message-ID: <20260616235939.1358663-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX7w2Z9RKZ0umI
 ajWqe+fvBH4/Y7uwCdtlIxtnq9LIf823UUe17aIg6rwbSHH6G7W0MYhagALuhrUPKb15fbrjgB1
 NAw6hkLeXF4vJwrYTNfp4qfnU4HbjMI=
X-Authority-Analysis: v=2.4 cv=D4d37PRj c=1 sm=1 tr=0 ts=6a31e37c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ccoGwOx6eHDXAKTbG8QA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 6BwQpTnyP_ZnhLSZHEQfiXQrCRp-WHLh
X-Proofpoint-ORIG-GUID: 6BwQpTnyP_ZnhLSZHEQfiXQrCRp-WHLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX0osfTtmcNoeM
 S+eYZsLf/THG99vUTdTHdD3PJ2kDejtO+dHfKjX98v2sRI5amf011dBLq4Yd2LmMT96OpOr4PUE
 aLir7kq3QKpDuw9698AmQ7fi/3+Mx3G5svPH6AbxbtHORV9TNdVuXP5yIiyFm+hOF4oY+QvanSq
 2aEKvTl4TgYnzPWsYSNwqIYyo3jI8vO/LNIJWrY/7ak2pnuhkrHRDhq/uq9bW1Lm1iNV+VMbOCf
 Ddq8ZwAml+bFTufruuizO8jx4scx0y9fz77GjNzfM04jQWs3kclhauMlWL88C+aWpwtc4gtMkAv
 BzjDLAaE83FIXNz/Mwn7AJidJwc3LHH755ruyLKyDW9aue6irKScTkI1XP4lvDvEO5mWySPOrF4
 EzV6aP+rnWHit/ZrPr6eEcPFp9mpDFm9rxKYjqF4wgYUCR7DZ1im5UYdewN5uRMu01Im66xHkuu
 ll+LZeBc4UE9sUs3iKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606160242
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We're still using "/soc/plic@..." as FDT nodename in virt.c.  This is
not the right nodename per the DT docs:

https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/sifive%2Cplic-1.0.0.txt

The nodename must be 'interrupt-controller@...' since the node inherits
the 'interrupt-controller' type.  In fact, ever since at least the 2020
Linux kernel commit c825a081c169cc7f ("dt-bindings: riscv: convert plic
bindings to json-schema") the correct nodename has been
'interrupt-controller' for the sifive PLIC controller.

There's no deprecation needed for bug fixes so we're just fixing the
name.  This was the policy we dud when fixing the aplic [1] and the
imsic [2] nodenames to 'interrupt-controller@...' as well.

The sifive_u PLIC FDT already uses the correct nodename for PLIC, so it
is safe to assume that available SW is already aware of the correct
nodename and this change won't affect well-behaved SW.

[1] commit 29390fd ("hw/riscv/virt.c: rename aplic nodename to 'interrupt-controller'")
[2] commit e8ad581 ("hw/riscv/virt.c: change imsic nodename to 'interrupt-controller'")

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd..fa464e644f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -335,7 +335,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     plic_phandles[socket] = (*phandle)++;
     plic_addr = s->memmap[VIRT_PLIC].base +
                 (s->memmap[VIRT_PLIC].size * socket);
-    plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
+    plic_name = g_strdup_printf("/soc/interrupt-controller@%lx", plic_addr);
     qemu_fdt_add_subnode(ms->fdt, plic_name);
     qemu_fdt_setprop_cell(ms->fdt, plic_name,
         "#interrupt-cells", FDT_PLIC_INT_CELLS);
-- 
2.43.0


