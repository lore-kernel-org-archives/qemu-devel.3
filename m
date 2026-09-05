Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB33C624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqd-0002xr-Jt; Sat, 05 Sep 2026 14:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqQ-0002sc-4L
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqM-0001e3-2g
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbelI1775030
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JDD8jh7duwunX0oSZc151pc7fMyJr/NjP+j+FOXU82g=; b=LwmXEyY8kQTnq18i
 L+2SSAH9C1Rt07HmGddMWE02+EmyVGDgIVJXSH1SwR1JjsqC7AhafN5RrfXfdPsf
 oRORDMiKqA7GzEBSFJ6TxGEEGjJKolri36bHkDAaZb+ouF1GsCYDevCoI0JoTqUR
 sWNm14gA4ajkDhfp4mGLK5SXq5kGiT6O2cXfkdSexUE6Rqy+wqFFevKeGtZbxEe/
 WuNeQNOZfxZMysPxu4SRNxLM8wecnlusKUOQ5eYeg7fq1CPqCVDjW+vuQQOwTu9H
 Tw6dUn+K18KwPzJW5rDb7loPN6zGHkgwCU9TVjtQCYg/OXRM8T9ZTOmOkGWqWIzs
 ha+2rQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8j9u40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d52734fc41so38022075ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631819; x=1789236619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JDD8jh7duwunX0oSZc151pc7fMyJr/NjP+j+FOXU82g=;
 b=ZVn7athjT59IROIxABn3/CMD3falKIP8IMtOhPHtk5aee45iiH59Wk4hkiDtyvh4TI
 wkakSOMwdqsdTUxp+d6vV4ClKN7DFLnbB4jVNSQ1fv4DnHS2RUGiMxdN5HbVOu7OgMSo
 9pXcUO+6X8uNmWSki2pMA2MSvLeQmOtoBZl/e02Wa31fUMNbGhhlu2/hDHj2RXTrOrJs
 i8xsgP5rdgvkxWEc+ks6O6O34eK7twVHo3IYQ+q50vjJ062EzKeWqgq6H9OQWOQiDzkY
 5DJPrz2RRA8R84afIKn29ZGftsYNSMyfjyn7dpqMQXVC8Nxn5pt1ThZiMSvG/9L908Fc
 ICdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631819; x=1789236619;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JDD8jh7duwunX0oSZc151pc7fMyJr/NjP+j+FOXU82g=;
 b=opV/I0JlCVkznTATvS6twYiYKE/Dy1vzM9faGVqB57m7iBbwAORPKSo3jdiDudlAsz
 yP9gy3oyxH51DsP7dsLpy19MGSYOYyGu1O9SdztIofznGZTmEvNjDsJSTKR9HELz+XZS
 pmJ0fJTkI/umpndxL8jbzK5Jo8iV6+MvfrCNpskYENvdaSCkFJqK3FQCblS3+tNVkmEV
 V4TQzTzD7kwViictFmvXIbTIaXufZz1UGJJELBMTATW+IlcqcVavj3wIAw6O5HStmiA/
 aXdYldZupipo1RDV9FOBbsYWBr7VZQP7qIF7pMr1VCo+M9BnN3/xXhORQGiJmWnfOaCM
 A+0g==
X-Gm-Message-State: AFuF++m2e/kADpxffKzRBqmjKGF/UQe3WDW8SnxVTCgEJl3wHllqUplf
 EWHgWKFUeeNge1UqE+H7PCRJMAydSVdHwMu8Pwelc0LjY69ZdmZ3SejoXkIzvqXtUI9FLvhR2Xm
 kzk3L1oc3qBNult06bJ66r5Etb+b2a63cdU6oSCBD8/Fv+g0/bNocW1r5N3aDRbTanA==
X-Gm-Gg: AYBFou3otMaVyOGiWs1HiD58n2H1nV5F56Lsh4wjAtuWnodwagWADFR5vLOyfopi+sr
 /vcdiv9f5HbxNAVk3YkCdgoLuMqOzeM3fnlX+NSIlFxxRdBLzXEJnHb3lowdJsnzFZhBUTiKWuf
 DFTSbP9mlHzwNziz86X0dMnzvhM7Tae9cweUVsoQCekSPmPFvFEr24BGQasq2wZBE72qImbAtbn
 XQHTFi9VShOEnqsX0jK49gYld+bfxZYT/hGbpz2E7d+VvU9rs5kjTT5rHDWudR4xmxxFliRBZ2U
 yZLyWVuzyDIR7WDMdWWtsX6fIbzZ4i3BvWOC7HFmynE1+5I7vQfnLwRZMJ3c6IPQGZackM1h3M1
 Rsn4W2R/1rAON7DfpfF4u7kFDag/3AKSIH6hB/jYglgwuYipZ
X-Received: by 2002:a17:902:d492:b0:2d9:68b7:c324 with SMTP id
 d9443c01a7336-2db125cce1bmr187923765ad.3.1788631818706; 
 Sat, 05 Sep 2026 11:10:18 -0700 (PDT)
X-Received: by 2002:a17:902:d492:b0:2d9:68b7:c324 with SMTP id
 d9443c01a7336-2db125cce1bmr187923285ad.3.1788631818221; 
 Sat, 05 Sep 2026 11:10:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 11/17] tests/tcg/hexagon: add sfrecipa edge case tests
Date: Sat,  5 Sep 2026 11:09:43 -0700
Message-Id: <20260905180949.1852673-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 4ReYxlOXwK9NkmbOHEa2Diyj7AQZQL-A
X-Proofpoint-ORIG-GUID: 4ReYxlOXwK9NkmbOHEa2Diyj7AQZQL-A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX5yCQT1UXM6DR
 2zYKp/hsbwv/iLJ+eBIQ8lqDYMgXBGbGhEBw+rEDUPdRopkLhjc+PBKkXd8aQD9JDJO5dIgFymf
 iSETev3pux7/elyzu0PPllC5VlFMFfNFdu+TtAETGjzvlcoCecPuPf5mBMk1kvpqhshgftEMW4A
 q/PBYmGe7gjQJ47XXHoSRCabna7uTx6YN5J2vfMMSJIKHHvi7AkfvGb19OF1zVbyM4uNakryuFv
 eE3h1jwjpw5DlziiicL0T+oJLdTNemsw+Uty5YxWxpl1J6Mc/SFXQx/MpHg0T9F8me+qGG7qKib
 wtaCkp3GROcPFGsqca5ncFdSnWDDb1X4dc4Z9H2QByPT0q30aRoWx6CKymeqmBGSoDMsFsHJQnX
 WQZVfrkOoT55HNtzLgsqu0hK4HMpiTtYTbDxn2fCiA9n5fLGjOLojV+m74Rm2xqfGuTgogQaayC
 u4AX8BWXI8GaaxjcPmw==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9c5b0b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=iLNeMspusdFBM-S5qpkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXyuZPkjHxMFaG
 YVymN7vBpssXYWRS2sUfNpRD9Eq+qHtChcd6RVmz6qgvLS2d6pUPZNYRg9T8/JJuM8xmqJ90+pj
 GWDUqRDZE90IdalubBmbi4RTFiOnOYg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QWRkIGVkZ2UgY2FzZSB0ZXN0cyBmb3IgdGhlIHNmcmVjaXBhIGluc3RydWN0aW9uCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVz
dHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIHwgODEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS90ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZm
LmMKaW5kZXggNzU2MWYzMWNkYzMuLmY4MjI2MmFiNGFjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cv
aGV4YWdvbi9mcHN0dWZmLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jCkBAIC0z
NDUsNiArMzQ1LDg2IEBAIHN0YXRpYyB2b2lkIGNoZWNrX3NmcmVjaXBhKHZvaWQpCiAgICAgY2hl
Y2szMihwcmVkLCAweDgwKTsKIH0KIAorLyoKKyAqIEhlbHBlciB0byBydW4gc2ZyZWNpcGEgYW5k
IGNhcHR1cmUgcmVzdWx0ICsgVVNSLgorICovCitzdGF0aWMgdm9pZCBkb19zZnJlY2lwYSh1aW50
MzJfdCBScywgdWludDMyX3QgUnQsCisgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAq
UmQsIHVpbnQzMl90ICp1c3Jfb3V0KQoreworICAgIHVpbnQzMl90IHJkLCB1c3I7CisKKyAgICBh
c20gdm9sYXRpbGUoQ0xFQVJfRlBTVEFUVVMKKyAgICAgICAgIiVbcmRdLHAwID0gc2ZyZWNpcGEo
JVtSc10sICVbUnRdKVxuXHQiCisgICAgICAgICIlW3Vzcl0gPSB1c3Jcblx0IgorICAgICAgICA6
IFtyZF0gIj1yIihyZCksIFt1c3JdICI9ciIodXNyKQorICAgICAgICA6IFtSc10gInIiKFJzKSwg
W1J0XSAiciIoUnQpCisgICAgICAgIDogInAwIiwgInIyIiwgInVzciIpOworICAgICpSZCA9IHJk
OworICAgICp1c3Jfb3V0ID0gdXNyOworfQorCisvKgorICogQWRkaXRpb25hbCBzZnJlY2lwYSBl
ZGdlIGNhc2VzOgorICogICAtIGluZi9pbmYsIDAvMCAtPiBOYU4gKyBpbnZhbGlkCisgKiAgIC0g
bm9ybWFsL2luZiwgMC9ub3JtYWwsIGluZi9ub3JtYWwKKyAqICAgLSBkZW5vbWluYXRvciB3aXRo
IGV4dHJlbWUgYmlhc2VkIGV4cG9uZW50cworICovCitzdGF0aWMgdm9pZCBjaGVja19zZnJlY2lw
YV9lZGdlcyh2b2lkKQoreworICAgIHVpbnQzMl90IHJkLCB1c3I7CisKKyAgICAvKiBpbmYgLyBp
bmYgLT4gaW52YWxpZCAqLworICAgIGRvX3NmcmVjaXBhKFNGX0lORiwgU0ZfSU5GLCAmcmQsICZ1
c3IpOworICAgIGNoZWNrX2Zwc3RhdHVzKHVzciwgVVNSX0ZQSU5WRik7CisKKyAgICAvKiAtaW5m
IC8gK2luZiAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoMHhmZjgwMDAwMCwgU0ZfSU5G
LCAmcmQsICZ1c3IpOworICAgIGNoZWNrX2Zwc3RhdHVzKHVzciwgVVNSX0ZQSU5WRik7CisKKyAg
ICAvKiAwIC8gMCAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoU0ZfemVybywgU0ZfemVy
bywgJnJkLCAmdXNyKTsKKyAgICBjaGVja19mcHN0YXR1cyh1c3IsIFVTUl9GUElOVkYpOworCisg
ICAgLyogLTAgLyArMCAtPiBpbnZhbGlkICovCisgICAgZG9fc2ZyZWNpcGEoU0ZfemVyb19uZWcs
IFNGX3plcm8sICZyZCwgJnVzcik7CisgICAgY2hlY2tfZnBzdGF0dXModXNyLCBVU1JfRlBJTlZG
KTsKKworICAgIC8qIG5vcm1hbCAvIGluZiAtPiBmaXh1cCAoUmQgPSAxLjApICovCisgICAgZG9f
c2ZyZWNpcGEoU0Zfb25lLCBTRl9JTkYsICZyZCwgJnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zf
b25lKTsKKworICAgIGRvX3NmcmVjaXBhKFNGX3R3bywgU0ZfSU5GLCAmcmQsICZ1c3IpOworICAg
IGNoZWNrMzIocmQsIFNGX29uZSk7CisKKyAgICAvKiAwIC8gbm9ybWFsIC0+IGZpeHVwIChSZCA9
IDEuMCkgKi8KKyAgICBkb19zZnJlY2lwYShTRl96ZXJvLCBTRl9vbmUsICZyZCwgJnVzcik7Cisg
ICAgY2hlY2szMihyZCwgU0Zfb25lKTsKKworICAgIGRvX3NmcmVjaXBhKFNGX3plcm9fbmVnLCBT
Rl90d28sICZyZCwgJnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsKKworICAgIC8qIGlu
ZiAvIG5vcm1hbCAtPiBmaXh1cCAoUmQgPSAxLjApICovCisgICAgZG9fc2ZyZWNpcGEoU0ZfSU5G
LCBTRl9vbmUsICZyZCwgJnVzcik7CisgICAgY2hlY2szMihyZCwgU0Zfb25lKTsKKworICAgIGRv
X3NmcmVjaXBhKDB4ZmY4MDAwMDAsIFNGX3R3bywgJnJkLCAmdXNyKTsKKyAgICBjaGVjazMyKHJk
LCBTRl9vbmUpOworCisgICAgLyoKKyAgICAgKiBEZW5vbWluYXRvciB3aXRoIGJpYXNlZCBleHBv
bmVudCA8PSAxLgorICAgICAqIFJzOiBiaWFzZWQgZXhwIDI2LCBSdDogYmlhc2VkIGV4cCAxLgor
ICAgICAqLworICAgIGRvX3NmcmVjaXBhKDI2VSA8PCAyMywgMVUgPDwgMjMsICZyZCwgJnVzcik7
CisgICAgY2hlY2szMl9uZShyZCwgMCk7CisKKyAgICAvKgorICAgICAqIERlbm9taW5hdG9yIHdp
dGggYmlhc2VkIGV4cG9uZW50ID4gMjUyLgorICAgICAqIEJvdGg6IGJpYXNlZCBleHAgMjUzLgor
ICAgICAqLworICAgIGRvX3NmcmVjaXBhKDI1M1UgPDwgMjMsIDI1M1UgPDwgMjMsICZyZCwgJnVz
cik7CisgICAgY2hlY2szMl9uZShyZCwgMCk7Cit9CisKIHN0YXRpYyB2b2lkIGNoZWNrX2Nhbm9u
aWNhbF9OYU4odm9pZCkKIHsKICAgICB1aW50MzJfdCBzZl9yZXN1bHQ7CkBAIC04ODcsNiArOTY3
LDcgQEAgaW50IG1haW4oKQogICAgIGNoZWNrX3NmbWlubWF4KCk7CiAgICAgY2hlY2tfZGZtaW5t
YXgoKTsKICAgICBjaGVja19zZnJlY2lwYSgpOworICAgIGNoZWNrX3NmcmVjaXBhX2VkZ2VzKCk7
CiAgICAgY2hlY2tfY2Fub25pY2FsX05hTigpOwogICAgIGNoZWNrX2ludnNxcnRhKCk7CiAgICAg
Y2hlY2tfc2ZmaXh1cG4oKTsKLS0gCjIuMzQuMQoK

