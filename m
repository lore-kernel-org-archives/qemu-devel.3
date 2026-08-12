Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485E9C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2To-00075i-Vp; Wed, 12 Aug 2026 02:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tm-00074w-7C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tk-0003nI-8g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C628ah2593507
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=BcRGjPqnpCJA2RaIKm7HtO5E9vmLu6p36g0B7rd/ZWY=; b=RS
 wfn3RqRiSvddo3vt+QSww3V8cG7su2HGnj+J4ORFZRPHTAW4TJHf7dnMv6NYuQTJ
 vX6/ajQZCJ6/Rpjyyp1tjhROJlZcb2knwyiS3Y7MYB13uv3zwrS1xvSTPZHeIjEM
 33Kd8noPOa5Fwg5DD84HJnI3bzVk3z9xn/K1B08jTunJjBdomcMJuzG+T/qJBlcN
 OKQ6e75x+vHCLgvy/w6oBnxJ5X/vcrh24LsrF7uTXvYacZ9OEzulQOsmS6mM/Pnv
 9EFoHvQT2kttUotArah8SD+lQd0bmE5nYTzYRkF6OmNi86Q8UfZAZcgBybJ8wkN2
 BL6Sjzu9L2SMdC7gSF+Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrje7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso897593a91.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516218; x=1787121018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BcRGjPqnpCJA2RaIKm7HtO5E9vmLu6p36g0B7rd/ZWY=;
 b=IqoQBW902hWkj8Gkwa3v/YWQZJL6+urzkqaAVtMDZe/TmQMbSazD0QerEwxb0vUYLS
 D9YY6d1/Ar8mFErcNxk4NOsFjfITOz6Y/cxpstF/KpnRNlBwtavS4HCRgR1GBCZscNrQ
 dP/uCBYM7NvN1YKS0wt/d1CO9ATQ9KLkelFWeD6Ksqs9mUgKB5A85Qz9Fsy0ym1pcdVj
 BOgQsTxyP+oFXa/LW01srj0SoUpCurUqCtfZRGQRxbRqQjw2vl2coZltia2KgJP0lbQG
 BRoM/9CPn2xhO2s95/I67YmBWiiVYTxQjIB6twkZYDBuj0zIDWSFRFCfSjRwvqGCPFpi
 cgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516218; x=1787121018;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BcRGjPqnpCJA2RaIKm7HtO5E9vmLu6p36g0B7rd/ZWY=;
 b=DTNxxS2CPeMTlAQA1xMsmLRrlfGBVtA7UQaqVDZasPmF5wED2lIq6NkWs8d3PWtnmL
 czTUMuaD0BSpJf9wNSfUqziYwqNMkEMN7XnMI8QqzX87x1wpKf1DHXSNcZtBi1NDG57k
 4QGlfBfNhRfZIHpb40/6KK+QAC3a0doldk2q+6fzA5WwafLRPpYQXNZfCE8Vxd5lLQEX
 kcsQE5/Y57Aa/PE32tJZCVUsg1XTdQ+C+NONz8L86F0BPUm9oDdT0ex5gvEXdEHnhiOo
 +V5QYcOub1ZU0fRmCKbwEeuWHNUBAtqRVoE9j+hgYC6Flqsr0JnILPTRk25VEUYZ154D
 SDyg==
X-Gm-Message-State: AOJu0Yw1K1bj90PbvJAS+mFjFwn0iEO2sbx2k+6DGNsjxumSgG8MinAy
 OLDd+8zMB28Dn2hwY06fBXUybHoMSzFQlkZIsNyvUvKpGm/aG6zeczltiP4/ctSY2VzqxfdGKuZ
 1tt+PoY6oZlf9qjuOALtxlom5vnKYY0tp05u/tpunfV/qDuoXOVXToK6lPloUvps5vw==
X-Gm-Gg: AR+sD13aKFNNnWE/Ep/woT+oxfgF+mYOQE4lxt2NyQBo6oaNdS9NYh/JpTpxHEXAfZu
 iQDbxQsWpwvEiGHoxvQEGTWcEsois2Pc6/ku/TxYOzKuYTefXglwGDJ8nEAhaZHWHnlxaHh313d
 1db6N+rU1Rm1rjzZG52umfcD5WvugkLbqjZYdA1kvgrK0ARTUE08miEGwSF2v+MunGaIClPia8k
 uNmAtyg/8G9gIAa9ir2aAo6CHj8grTM22g78sTBUf++aCYXzejbMdf5N88/EEaeWgGzNLKntEcE
 AF6QexJKS+Ql+DqQEtc7/jRj98/1R3ml4mzDXh/0ePgNUKN/a/Hbctz30L/XKPJ0TiXapRo9qNK
 RZfKv5sFnNDtwIgUsSdxVEluFQAs48EJI+bMQSnQbPPLpwYpw
X-Received: by 2002:a17:90b:440e:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-393014b609fmr2536451a91.19.1786516218046; 
 Tue, 11 Aug 2026 23:30:18 -0700 (PDT)
X-Received: by 2002:a17:90b:440e:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-393014b609fmr2536409a91.19.1786516217597; 
 Tue, 11 Aug 2026 23:30:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 10/41] hw/hexagon/virt: instantiate virtio-mmio transports
Date: Tue, 11 Aug 2026 23:29:01 -0700
Message-Id: <20260812062932.543840-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ipcfHIzU9_osgat_rH6qeuuEPmI1Qzwv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX1U5zL/wxeNYP
 h/DAE7E7qCAut5INziGmT9ENjRvexmeTmbU5K4beGShwaJFyOiCFzuCxup7LzsPhzAC5lCBsuNa
 5TzORQopVZk60/EwlQJXW9vu5u/cRMY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX79d9wiK8hq+e
 KjnfB2SFyA6ioWznF705uNcpL/I86J5CGFLu6GmCAPoU5ZJ+T8uMvAD8+ddNKoAKA8Ly8cqNxSL
 s+/Jc6AUnioXN/Y5xM7kguqLekFB5Svtu6KAieFznnDiOWEPmBvUu7mCCQvS2cAheMxqvOUasD6
 BHyUY0zqGUDWgG35+owaH/Udzp8OIIhGYdgd8IQ09stjsITGKf0fP+SHwPMIn7VnRWhMBtn4pQR
 MynAWr4Zqg9NAHFWIf/rsQuyslOATWrD1D971O7CQ2KDlVoztxhZgEMbFSZJV8xwBZda6uZq3MU
 6iJ/IaURI0bPMP1527vAgqgQCA3497/NryI9RsC24ymCiPTmmkGKAgdBCUiDXMzh0ecQdwwMkKE
 Ex7CsmwZ5GvaUMxOLxA7y4VHOY7+CfSw703ZCEfmGvgOA9HcqyBNYNng40Q8q8lZstL5kieHw3q
 wYJp8LCqqZq+mP0Is0g==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c12fa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qfYuoNLC281KTBfHwCsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: ipcfHIzU9_osgat_rH6qeuuEPmI1Qzwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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

QWRkIGEgVklSVF9NTUlPIHJlZ2lvbiBhbmQgdmlydGlvLW1taW8gdHJhbnNwb3J0cywgd2lyZWQg
aW50byBsMnZpYy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QG9zcy5xdWFsY29tbS5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjA4MDYwNDI3MjMuMzc4NTM2OS0xMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggfCAgMyArKysKIGh3L2hleGFnb24vdmlydC5j
ICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hleGFnb24vdmly
dC5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaAppbmRleCBjZjBjZDJmOGYyMi4uNGNhMmYx
ZWY4NTkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgKKysrIGIvaW5jbHVk
ZS9ody9oZXhhZ29uL3ZpcnQuaApAQCAtMTEsNiArMTEsOCBAQAogI2luY2x1ZGUgImh3L2hleGFn
b24vaGV4YWdvbi5oIgogI2luY2x1ZGUgInRhcmdldC9oZXhhZ29uL2NwdS5oIgogCisjZGVmaW5l
IFZJUlRJT19ERVZfQ09VTlQgOAorCiBzdHJ1Y3QgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgewog
ICAgIEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgcGFyZW50X29iajsKIApAQCAtMTksNiArMjEs
NyBAQCBzdHJ1Y3QgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgewogICAgIE1lbW9yeVJlZ2lvbiB0
Y207CiAgICAgTWVtb3J5UmVnaW9uIGJpb3M7CiAgICAgQ2xvY2sgKmFwYl9jbGs7CisgICAgRGV2
aWNlU3RhdGUgKnZpcnRpb19tbWlvW1ZJUlRJT19ERVZfQ09VTlRdOwogfTsKIAogdm9pZCBoZXhh
Z29uX2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKTsK
ZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5kZXgg
OWE2ODA4NTJjM2MuLmZmMDc3MGNmYzQ2IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQuYwor
KysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtMzAsMTEgKzMwLDE5IEBACiAKIGVudW0gewogICAg
IFZJUlRfVUFSVDAsCisgICAgVklSVF9NTUlPLAogICAgIFZJUlRfRkRULAogfTsKIAorLyoKKyAq
IFZpcnRpbyBJUlFzIHJ1biBmcm9tIFZJUlRJT19JUlFfQkFTRSB0bworICogVklSVElPX0lSUV9C
QVNFICsgVklSVElPX0RFVl9DT1VOVCAtIDEKKyAqLworc3RhdGljIGNvbnN0IGludCBWSVJUSU9f
SVJRX0JBU0UgPSAxNjsKKwogc3RhdGljIGNvbnN0IE1lbU1hcEVudHJ5IGJhc2VfbWVtbWFwW10g
PSB7CiAgICAgW1ZJUlRfVUFSVDBdID0geyAweDEwMDAwMDAwLCAweDAwMDAwMjAwIH0sCisgICAg
W1ZJUlRfTU1JT10gPSB7IDB4MTEwMDAwMDAsIDB4MDAwMDEwMDAgfSwKICAgICBbVklSVF9GRFRd
ID0geyAweDk5ODAwMDAwLCAweDAwNDAwMDAwIH0sCiB9OwogCkBAIC0xNjcsNyArMTc1LDI1IEBA
IHN0YXRpYyB2b2lkIGZkdF9hZGRfY3B1X25vZGVzKGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0
YXRlICp2bXMpCiAgICAgfQogfQogCitzdGF0aWMgdm9pZCBjcmVhdGVfdmlydGlvX2RldmljZXMo
SGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZtcykKK3sKKyAgICBod2FkZHIgc2l6ZSA9IGJhc2Vf
bWVtbWFwW1ZJUlRfTU1JT10uc2l6ZTsKIAorICAgIGZvciAoaW50IGkgPSAwOyBpIDwgVklSVElP
X0RFVl9DT1VOVDsgaSsrKSB7CisgICAgICAgIGludCBpcnEgPSBWSVJUSU9fSVJRX0JBU0UgKyBp
OworICAgICAgICBod2FkZHIgYmFzZSA9IGJhc2VfbWVtbWFwW1ZJUlRfTU1JT10uYmFzZSArIGkg
KiBzaXplOworICAgICAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gcWRldl9uZXcoInZpcnRpby1tbWlv
Iik7CisgICAgICAgIFN5c0J1c0RldmljZSAqcyA9IFNZU19CVVNfREVWSUNFKGRldik7CisKKyAg
ICAgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChPQkpFQ1QoTUFDSElORSh2bXMpKSwgInZp
cnRpby1tbWlvWypdIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1Qo
ZGV2KSk7CisgICAgICAgIHN5c2J1c19yZWFsaXplX2FuZF91bnJlZihzLCAmZXJyb3JfZmF0YWwp
OworICAgICAgICBzeXNidXNfbW1pb19tYXAocywgMCwgYmFzZSk7CisgICAgICAgIHN5c2J1c19j
b25uZWN0X2lycShzLCAwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bp
b19pbih2bXMtPnBhcmVudF9vYmoubDJ2aWMsIGlycSkpOworICAgICAgICB2bXMtPnZpcnRpb19t
bWlvW2ldID0gZGV2OworICAgIH0KK30KIAogdm9pZCBoZXhhZ29uX2xvYWRfZmR0KGNvbnN0IEhl
eGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMpCiB7CkBAIC0yNDYsNiArMjcyLDggQEAgc3RhdGlj
IHZvaWQgdmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAKICAgICBmZHRfYWRkX2h2eCh2bXMs
IG1fY2ZnKTsKIAorICAgIGNyZWF0ZV92aXJ0aW9fZGV2aWNlcyh2bXMpOworCiAgICAgZ19hdXRv
ZnJlZSBIZXhhZ29uQ1BVICoqY3B1cyA9IGdfbmV3KEhleGFnb25DUFUgKiwgbXMtPnNtcC5jcHVz
KTsKIAogICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbXMtPnNtcC5jcHVzOyBpKyspIHsKLS0gCjIu
MzQuMQoK

