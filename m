Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77693CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzE-0007ni-1n; Thu, 11 Jun 2026 01:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzB-0007n4-UX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzA-0000rF-1R
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GPtI3817101
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=; b=D4Ss/skr9L752tuT
 iP5LASWDhDi4o0Q8sNlIimvVxlcaLHVi0C8oMx2Hww3apRAuOiqTPatjGoNMg9gr
 9ffXtMYyPzzX4UmPgOpmQRZf8FhZCyqUrL5qtBcNUr+1Sm9+x07mxto0dT0UKJHI
 jsshhMYqb4RU6oENZ4FnNANWkRwLVNkN4ndH/QAWus7+eed1He3lWJhvp8ZPGX3F
 CrtfV4loh1FTC8IFu/ilRHvEN5ZInt1ag27JvKpRWt95REHbqlh5OVKL7Luy+Ted
 KL1pC88250Ibaec0+wU0X3zQXw3nd0LKw6FvJKBosm5wNt1X0W3lkylQaG7Pupn+
 AqMfoQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6usrr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307fe856724so1877004eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155775; x=1781760575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=ab9XyeCAzSQ5TqkWPCYh38Kor4YRgBb81vLdCOf17da4P5d6QaHvq7HUn9KRDLotS4
 zQBb02Cu8JsRwSOXYbnaJNAkNvrB0+cRYFMdsvVlYealeZS8WzNRrHJo1jOubLB4JxPK
 m7Z4/4p0EbP3dA2zqzBL+1lFiXSfnRG6APpG5/Wh6F7tXefeqxtmWIljN3O5YFShBLKY
 h9H2+muSN9+LDguEfVidoZ7uRwjbZaLdR+ucMk6Qb1SxngnH8a7Cc6G53xpcnWjjOqFh
 Hr5XzOCKEM2q+/lR4KifNFQrO56VtZ9MFdbzWpdI2/OiDsvK8QXPCGC4xquVf2jIYVq4
 yODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155775; x=1781760575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=SRr3/gSZkU/2wNTeZmrv53WIpUef+mdpmfEoPhkcTZXDCgYGC5cZprq47g8mfQQBW2
 vFenDnQlRHczrkP1uiiU+Lc7TQ/j24iN92r3KWv96ZY0DsKM0haYRK9gotiA+qIc2ORc
 EJ3MFtDHd3+iFJgxMqVZixGgGZlDhUMawWr8UPkcqVKkoIvua5UfaQJ+23lZ7mf9Qfja
 5z8BV2trDSNhMSPWr88n4qsFofHBPqVP0AxSvda/4cLMi3QDZxysbcyhyTLUxgESolan
 gX8ayFJAO6pOM9P6eKfyLFq/t6yGzDUouGbiFgeg6Dr0TQcIqRjN3AGS23tjr0+0lX4E
 QICA==
X-Gm-Message-State: AOJu0Yywa6qihmigpqCY/Nc6doUO83EPk6ZuBw0qGQH4WgklGxua2MiY
 REa41XyC7H1J6rhnWT/Ys39jmrR/zQ93FqSdh6UC1HoBCiZrtRwvGhGG1w3soPgCEnjCdSsTxbB
 mGAdj894ssA/XDFRfmzoWHhlc9tuUGjL3AYfSBMmp0VajLrP3FreFLp/P93eehU3F0Q==
X-Gm-Gg: Acq92OGjoNCXnkZtGr8jd3nb1JJfV9YyEGheqK++lVlV3h+NfaN49HIPd4DP+kjqFzG
 kpLefRqkUGmhhKVZb8zADtXKxE8wfypOtgRZXniHai8DLY9zIrHAkxz2lEYlsUks0YvOuHPn4E5
 lPH/WXb1/FI0/5sBWq6nyUFrHXDtxqguf8/OPWgxMIEUd92dfNlC0oIkA82fsvqWgkQpwcvEPXn
 CbcEIGzVfpkxP4Z5fS0lcggk4iVdD+SnupU2+JP653bHgPNidgjJ2/jpP/4WaeR0XKefwVrm5RK
 jZJc1HBouIad/OxEYCYcdfwCA0DXIcH3gpsyW40iFFmGrwqg3qx5bedK8GK8yZcZtIKPjIrt32L
 ZvdWOm9xLFXf78AMRtCPkOUdi+YL9i8fKVX+fBvWgLDpN/9MnFvC4mdSJ/7eXy/c31+cmvLkDOh
 oIMRX4
X-Received: by 2002:a05:7301:1984:b0:2f4:3a9c:818c with SMTP id
 5a478bee46e88-30804bb0352mr1109069eec.29.1781155775439; 
 Wed, 10 Jun 2026 22:29:35 -0700 (PDT)
X-Received: by 2002:a05:7301:1984:b0:2f4:3a9c:818c with SMTP id
 5a478bee46e88-30804bb0352mr1109045eec.29.1781155774861; 
 Wed, 10 Jun 2026 22:29:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Define register fields for system regs
Date: Wed, 10 Jun 2026 22:28:41 -0700
Message-Id: <20260611052857.3911981-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a47c0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX1zpyiHvguNLA
 XH67pAz2gZYTtE/QG7gQN3Znf95xTL3DKX9sYgi9XUMyJ0uFwq0rpkrYZQmm1Jbgs19Rh/ECxGb
 seap8gSvysTN6es+hMUr0Rb0JG6ql5s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX8pqszIPnLwHv
 Mz2p/cnB9E+Omxm6FIWBROPcGycuDX0B+fBYxWKwawJb9N02B7MES37wfjhP0pB9lTSOqa0vkBx
 bLMH6B+C7EaGenRITD10MqyuU12yBtqzJNtUFKvpYRDerC4PS21RGR1eSLAynyAOsYaK/WzNgXb
 b3WKE/cEK9Q+LkNYZfS/OXbQ72WEjO+J5vPE7vjc253RuPkpl6xZaju/6TnneRcIBhGAKSPneH8
 wvDFRaDVB2lAJRLdlLa0G/Mn/pqFVeOybxpQYVno8AN2D63z2ZCroWwGWM165i+EoZ/2zHEmfKB
 NSOQmlEcoNz008b69qG8lnR0A8QcUpn9ZVk++Am0UMs3mfVvya5NQUAXgfRbiW/XoJsytJUxc+0
 H+6jptgmfX2u6hMNmMR2lo088gOTtg51gUPe2YxlsLvJuBpKd9XkyCIuLbvcgKIoNESfLRx7pdn
 V9R/RrB30SDmvM//xwQ==
X-Proofpoint-GUID: D-10RYhFjSZY99TzX9BaMhzrjS5UwWRp
X-Proofpoint-ORIG-GUID: D-10RYhFjSZY99TzX9BaMhzrjS5UwWRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgdGhlIHJlZ2lzdGVy
IGZpZWxkcyBmb3Igc3NyLCBzY2hlZGNmZywgc3RpZCwgYmVzdHdhaXQsIGNjciwKbW9kZWN0bCwg
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyB8IDk2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkc19kZWYuaC5pbmMKaW5kZXggZjJhNThkNDg2YzUuLjliMTEyY2NlYzY0IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYworKysgYi90YXJnZXQv
aGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwpAQCAtMzksMyArMzksOTkgQEAgREVGX1JFR19G
SUVMRChVU1JfRlBEQlpFLCAgICAgICAgMjYsIDEpCiBERUZfUkVHX0ZJRUxEKFVTUl9GUE9WRkUs
ICAgICAgICAyNywgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQVU5GRSwgICAgICAgIDI4LCAxKQog
REVGX1JFR19GSUVMRChVU1JfRlBJTlBFLCAgICAgICAgMjksIDEpCisKK0RFRl9SRUdfRklFTEQo
SVBFTkRBRF9JQUQsIDE2LCAxNikKK0RFRl9SRUdfRklFTEQoSVBFTkRBRF9JUEVORCwgMCwgMTYp
CisKK0RFRl9SRUdfRklFTEQoU0NIRURDRkdfRU4sIDgsIDEpCitERUZfUkVHX0ZJRUxEKFNDSEVE
Q0ZHX0lOVE5PLCAwLCA0KQorREVGX1JFR19GSUVMRChCRVNUV0FJVF9QUklPLCAwLCA5KQorCisK
Ky8qIFBURSAoYWthIFRMQiBlbnRyeSkgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKFBURV9QUEQs
IDAsIDI0KQorREVGX1JFR19GSUVMRChQVEVfQywgMjQsIDQpCitERUZfUkVHX0ZJRUxEKFBURV9V
LCAyOCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1IsIDI5LCAxKQorREVGX1JFR19GSUVMRChQVEVf
VywgMzAsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9YLCAzMSwgMSkKK0RFRl9SRUdfRklFTEQoUFRF
X1ZQTiwgMzIsIDIwKQorREVGX1JFR19GSUVMRChQVEVfQVNJRCwgNTIsIDcpCitERUZfUkVHX0ZJ
RUxEKFBURV9BVFIwLCA1OSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0FUUjEsIDYwLCAxKQorREVG
X1JFR19GSUVMRChQVEVfUEEzNSwgNjEsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9HLCA2MiwgMSkK
K0RFRl9SRUdfRklFTEQoUFRFX1YsIDYzLCAxKQorCisvKiBTWVNDRkcgZmllbGRzICovCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19NTVVFTiwgMCwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lDRU4s
IDEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19EQ0VOLCAyLCAxKQorREVGX1JFR19GSUVMRChT
WVNDRkdfSVNEQlRSVVNURUQsIDMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19HSUUsIDQsIDEp
CitERUZfUkVHX0ZJRUxEKFNZU0NGR19JU0RCUkVBRFksIDUsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19QQ1lDTEVFTiwgNiwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1YyWCwgNywgMSkKK0RF
Rl9SRUdfRklFTEQoU1lTQ0ZHX0lHTk9SRURBQk9SVCwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BNLCA5LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVExCTE9DSywgMTEsIDEpCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19LMExPQ0ssIDEyLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfQlEs
IDEzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfUFJJTywgMTQsIDEpCitERUZfUkVHX0ZJRUxE
KFNZU0NGR19ETVQsIDE1LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJDRkcsIDE2LCAzKQor
REVGX1JFR19GSUVMRChTWVNDRkdfSVRDTSwgMTksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19M
Mk5XQSwgMjEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMk5SQSwgMjIsIDEpCitERUZfUkVH
X0ZJRUxEKFNZU0NGR19MMldCLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyUCwgMjQs
IDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19TTFZDVEwwLCAyNSwgMikKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX1NMVkNUTDEsIDI3LCAyKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQQVJUU0laRSwg
MjksIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkdDQSwgMzEsIDEpCisKKy8qIFNTUiBmaWVs
ZHMgKi8KK0RFRl9SRUdfRklFTEQoU1NSX0NBVVNFLCAwLCA4KQorREVGX1JFR19GSUVMRChTU1Jf
QVNJRCwgOCwgNykKK0RFRl9SRUdfRklFTEQoU1NSX1VNLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQo
U1NSX0VYLCAxNywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0lFLCAxOCwgMSkKK0RFRl9SRUdfRklF
TEQoU1NSX0dNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1YwLCAyMCwgMSkKK0RFRl9SRUdf
RklFTEQoU1NSX1YxLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0JWUywgMjIsIDEpCitERUZf
UkVHX0ZJRUxEKFNTUl9DRSwgMjMsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9QRSwgMjQsIDEpCitE
RUZfUkVHX0ZJRUxEKFNTUl9CUCwgMjUsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRTIsIDI2LCAx
KQorREVGX1JFR19GSUVMRChTU1JfWEEsIDI3LCAzKQorREVGX1JFR19GSUVMRChTU1JfU1MsIDMw
LCAxKQorREVGX1JFR19GSUVMRChTU1JfWEUsIDMxLCAxKQorCisvKiBtaXNjIHJlZ2lzdGVycyAq
LworREVGX1JFR19GSUVMRChJTUFTS19NQVNLLCAwLCAxNikKKworREVGX1JFR19GSUVMRChTVElE
X1BSSU8sIDE2LCA4KQorREVGX1JFR19GSUVMRChTVElEX1NUSUQsIDAsIDgpCisKKy8qIE1PREVD
VEwgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKE1PREVDVExfRSwgMCwgOCkKK0RFRl9SRUdfRklF
TEQoTU9ERUNUTF9XLCAxNiwgOCkKKworREVGX1JFR19GSUVMRChDQ1JfTDFJQ1AsIDAsIDIpCitE
RUZfUkVHX0ZJRUxEKENDUl9MMURDUCwgMywgMikKK0RFRl9SRUdfRklFTEQoQ0NSX0wyQ1AsIDYs
IDIpCisKK0RFRl9SRUdfRklFTEQoQ0NSX0hGSSwgMTYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9I
RkQsIDE3LCAxKQorREVGX1JFR19GSUVMRChDQ1JfSEZJTDIsIDE4LCAxKQorREVGX1JFR19GSUVM
RChDQ1JfSEZETDIsIDE5LCAxKQorREVGX1JFR19GSUVMRChDQ1JfU0ZELCAyMCwgMSkKKworREVG
X1JFR19GSUVMRChDQ1JfR0lFLCAyNCwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0dURSwgMjUsIDEp
CitERUZfUkVHX0ZJRUxEKENDUl9HRUUsIDI2LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1JFLCAy
NywgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZWMSwgMjksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9W
VjIsIDMwLCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYzLCAzMSwgMSkKLS0gCjIuMzQuMQoK

