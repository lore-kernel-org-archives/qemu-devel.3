Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE025C624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqa-0002vc-Iq; Sat, 05 Sep 2026 14:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqU-0002tW-CD
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqQ-0001eb-JE
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbIAQ2450137
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i1RDuyDS8Rqj2Y+ETOxhgk+mHAnCAJmadFkHUNRuBtE=; b=fC65CsS/8fZYqz3c
 5tGKU6gdiBRVZya3pjrSGJ4ssTUs2n0ckMfkNzeyWfqcyOqPt17DhY/Ss6cvnR66
 UJmcrkgcJzGmSw1wFGDY+HPHL0mjiLwDKaE9e/B+oAFG0LXyekkxoR/pQF4MlImW
 RTErshwiuuYJEfahME9D9O+1Dgk5EWIaqvekjNwUUK2QFcZy5juW2FaiZbx85K2z
 fyQWDHZgxOqF+l6XRaZxTCh7UXvXSIY/0CPRjQDxazMUCYLKF6PVS5ytZEcJF/Z7
 18KBPNmBNmo4TdwZRPCLLmn2sHFonnXXIBZiRLKTrkqdqWvr+8EfLvIrVSRgitFi
 72kn6g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuehxg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84a251c2e3eso3800113b3a.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631824; x=1789236624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i1RDuyDS8Rqj2Y+ETOxhgk+mHAnCAJmadFkHUNRuBtE=;
 b=ZRpyZqPn2bfLRkT4YAunuUIh2b0sSE7nVhpDsPXsTe7yO+KjpWNSRfLMjpcUdwi5VC
 3piWMEOlQfsKHYlzepmpRci8rVU1WfvfNT2F00yFDGKpRsJUr5FHE1JUhp6+j8UEgRAG
 ZL9nqRKIkma8/6/4dSmxQ/RPCi13WdgFLPpf7db+ZN/M1PaM5gRt9k6JUDkSfHYmErhe
 M6m8y+B1J6qWySQizueliYp1fbo6EsR/aOffIaTcdONYuOf0ZYxLA2Rlyywvy6hcaDM8
 g3AnIsfeAwIz1I+KuV0w3PVORtXP7ALgod2pznVFkn3Rja+8zxZtBW/w005vB+VE+AaB
 c69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631824; x=1789236624;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i1RDuyDS8Rqj2Y+ETOxhgk+mHAnCAJmadFkHUNRuBtE=;
 b=QwB4t72kuoUmReLAv1LV8nvVBGvXsm+wC0fJLBTTETQgSTQ+CDmAFid/QmluSvOVjX
 eV7irEcRIxgrFEoFINAWZ2XUPSzDBTOKeGqIdEH7ijdyIAWW3AZrkZXEIT+b655Ahez2
 QU7kS06EFXR4LPo/v8zIFjgPIN+UscK9O5zZCde5O0ayWrxA8TSq8kf3b79QFrDHQLaN
 or1Ur4L5AJzdzl1Pnax7OT9OY2x1WZmy1kxcP/Lqd+Jp8XCyHsR2XKx1y37EsyzdkCxL
 rOX8kTp2q/OurayBws8UMEI5GzmuXAMmxCpeQa6qP7dj211FnVTYp+8JJgydglaizNMA
 8zyg==
X-Gm-Message-State: AFuF++mnj2lzlvrqHXMXhHq731hmA+mr9eugxKh8mApExK3iiVVA6xdY
 CKn2Q6H1247/ZU2BTG1x/51qjdc2nNFcAIBPEVnVjaL2YFhdeD6a0OLuNHpNzmuVinAk/RQHDWu
 idZlbJTRVzMA7gc2ManNgnH5jSbSrIcbQxa/Ld625kpws7f5eFoFYkIR1slhtAp94qw==
X-Gm-Gg: AYBFou3eUvDCjleqgRctzgmAWZTAjv9WpAZo4HwFvCSBsyzHib+SvIyaCwh+J1e2lml
 zpFkJj4PHOlSDQF9fA7IHPqJ/8VHNENCrW6pbvgoSqo8FbqnSS4FB6/QIj8kZLYRj1u+06bqMwT
 VpJFhJ9D6sO77eG+DrNi6eDQzmNS99zT4YO3e0THN4LiuaaeSdDmGA5QsOqo6mSRprNys8sINkY
 sCN9dP/KAdI2r8jAp+/mW+0nop86SwOZqFGVtnwtuK//wivXtzXvm9E7bf2O5MEHLNmABdkhqw5
 BFUALQeT1srkkC68wrYAk3vtExm3ujQTNun37xYiQLpQ053mgV4CAHiTbj8stR1C6qs5QCE0lgy
 8ustWFSE5BVien1OgtpAO0+1qWqDtdOHZTaQLHuhQonEsvpKI
X-Received: by 2002:a05:6a21:4c0c:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3da213cc8eemr21992982637.5.1788631824464; 
 Sat, 05 Sep 2026 11:10:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c0c:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3da213cc8eemr21992943637.5.1788631823991; 
 Sat, 05 Sep 2026 11:10:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 13/17] tests/tcg/hexagon: add unconditional store-immediate
 tests
Date: Sat,  5 Sep 2026 11:09:45 -0700
Message-Id: <20260905180949.1852673-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX6IkrOJcIUeGn
 yzdIwOkYG51DRnVSCH0onT6QGuJOu1mavxKzlcCztRn/Ccz88xOKNrBogIFuYA7Wsc3KXqChfrU
 UxHG333sacRJGC38d3P1Fb/t4nPc8KTg4ueNQ6ZZXMJn8sOH0ocZmtNWCBPu3grK/JjfCUgdNY0
 wD3H1TXLOC81rxIm3LsAvBQp3svQbk6gYzTkQllzbjrWMfunUMkPB22qX++xb7a9+kiVsgJ8hnV
 EqlD6JKbjSMxBbE6exlij+QeeqzORx55uJFWTklQpN4gsc/8k0QhQB2zDYL+ru0kGBqWJjTWvSQ
 U3Cow/GyT1kY7FCKpujAzjIbLWnI/ZySbERn2zDMMpI21i0RE2somcmJGDSVOLGfvBYbhD1+9Ia
 9mthdrlyFO8hlRIYt236uhK7qskJVaVn6xZYrMCKNwCoXTYxO1jrAdBpZAQg+l+1F2uX/TcB9CT
 W66YXP5nPHKYrLBuleQ==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9c5b11 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0l-Zo2GwZyP_T63qDoMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 2kayx3pr1mlvKL8MYE3SeCjE70px-0UN
X-Proofpoint-ORIG-GUID: 2kayx3pr1mlvKL8MYE3SeCjE70px-0UN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX6wq3YBHgQ81G
 5WpRelbRbLTobhwDGUUbX8ffk1jLRtUFacEeHoQZIi50PVT+l0paNmhfYxxbaoCgsyrb23tILS+
 e3eU35obACXyUlGVBtvTyYA0XeZhdeM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vbWlzYy5jIGIvdGVzdHMvdGNnL2hleGFnb24vbWlz
Yy5jCmluZGV4IGNhMjJiYjc5ZjdiLi5jMDc1NDdiNmY2OCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNn
L2hleGFnb24vbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYwpAQCAtNDA0LDYg
KzQwNCw0OCBAQCB2b2lkIHRlc3RfZHBtcHlzc19ybmRfczAodm9pZCkKICAgICBjaGVjazMyKGRw
bXB5c3Nfcm5kX3MwKDB4N2ZmZmZmZmYsIDB4N2ZmZmZmZmYpLCAweDNmZmZmZmZmKTsKIH0KIAor
c3RhdGljIHVpbnQ4X3Qgc3RvcmVpbW1fYnl0ZV9hcnJheVsxNl07CitzdGF0aWMgdWludDE2X3Qg
c3RvcmVpbW1faGFsZl9hcnJheVsxNl07CitzdGF0aWMgdWludDMyX3Qgc3RvcmVpbW1fd29yZF9h
cnJheVsxNl07CisKKy8qCisgKiBVbmNvbmRpdGlvbmFsIHN0b3JlLWltbWVkaWF0ZSBpbnN0cnVj
dGlvbnMgKFM0X3N0b3JlaXIqX2lvKS4KKyAqIFRoZSBwcmVkaWNhdGVkIGZvcm1zIGFyZSB0ZXN0
ZWQgYWJvdmU7IHRoZXNlIGV4ZXJjaXNlIHRoZSBiYXNlIGVuY29kaW5nCisgKiB3aXRoIHBvc2l0
aXZlIGFuZCBuZWdhdGl2ZSAjUzggaW1tZWRpYXRlIHZhbHVlcy4KKyAqLworc3RhdGljIHZvaWQg
Y2hlY2tfc3RvcmVfaW1tKHZvaWQpCit7CisgICAgLyogbWVtYihScysjdTY6MCkgPSAjUzggKi8K
KyAgICBtZW1zZXQoc3RvcmVpbW1fYnl0ZV9hcnJheSwgMCwgc2l6ZW9mKHN0b3JlaW1tX2J5dGVf
YXJyYXkpKTsKKyAgICBhc20gdm9sYXRpbGUoIm1lbWIoJVtwdHJdICsgIzApID0gIzB4MTJcblx0
IgorICAgICAgICAgICAgICAgICA6IDogW3B0cl0gInIiKHN0b3JlaW1tX2J5dGVfYXJyYXkpIDog
Im1lbW9yeSIpOworICAgIGNoZWNrMzIoc3RvcmVpbW1fYnl0ZV9hcnJheVswXSwgMHgxMik7CisK
KyAgICBhc20gdm9sYXRpbGUoIm1lbWIoJVtwdHJdICsgIzMpID0gIy0xXG5cdCIKKyAgICAgICAg
ICAgICAgICAgOiA6IFtwdHJdICJyIihzdG9yZWltbV9ieXRlX2FycmF5KSA6ICJtZW1vcnkiKTsK
KyAgICBjaGVjazMyKHN0b3JlaW1tX2J5dGVfYXJyYXlbM10sIDB4ZmYpOworCisgICAgLyogbWVt
aChScysjdTY6MSkgPSAjUzggKi8KKyAgICBtZW1zZXQoc3RvcmVpbW1faGFsZl9hcnJheSwgMCwg
c2l6ZW9mKHN0b3JlaW1tX2hhbGZfYXJyYXkpKTsKKyAgICBhc20gdm9sYXRpbGUoIm1lbWgoJVtw
dHJdICsgIzApID0gIzB4MzRcblx0IgorICAgICAgICAgICAgICAgICA6IDogW3B0cl0gInIiKHN0
b3JlaW1tX2hhbGZfYXJyYXkpIDogIm1lbW9yeSIpOworICAgIGNoZWNrMzIoc3RvcmVpbW1faGFs
Zl9hcnJheVswXSwgMHgzNCk7CisKKyAgICBhc20gdm9sYXRpbGUoIm1lbWgoJVtwdHJdICsgIzQp
ID0gIy0xXG5cdCIKKyAgICAgICAgICAgICAgICAgOiA6IFtwdHJdICJyIihzdG9yZWltbV9oYWxm
X2FycmF5KSA6ICJtZW1vcnkiKTsKKyAgICBjaGVjazMyKHN0b3JlaW1tX2hhbGZfYXJyYXlbMl0s
IDB4ZmZmZik7CisKKyAgICAvKiBtZW13KFJzKyN1NjoyKSA9ICNTOCAqLworICAgIG1lbXNldChz
dG9yZWltbV93b3JkX2FycmF5LCAwLCBzaXplb2Yoc3RvcmVpbW1fd29yZF9hcnJheSkpOworICAg
IGFzbSB2b2xhdGlsZSgibWVtdyglW3B0cl0gKyAjMCkgPSAjMHg1NlxuXHQiCisgICAgICAgICAg
ICAgICAgIDogOiBbcHRyXSAiciIoc3RvcmVpbW1fd29yZF9hcnJheSkgOiAibWVtb3J5Iik7Cisg
ICAgY2hlY2szMihzdG9yZWltbV93b3JkX2FycmF5WzBdLCAweDU2KTsKKworICAgIGFzbSB2b2xh
dGlsZSgibWVtdyglW3B0cl0gKyAjOCkgPSAjLTFcblx0IgorICAgICAgICAgICAgICAgICA6IDog
W3B0cl0gInIiKHN0b3JlaW1tX3dvcmRfYXJyYXkpIDogIm1lbW9yeSIpOworICAgIGNoZWNrMzIo
c3RvcmVpbW1fd29yZF9hcnJheVsyXSwgMHhmZmZmZmZmZik7Cit9CisKIGludCBtYWluKCkKIHsK
ICAgICBpbnQzMl90IHJlczsKQEAgLTU0Nyw2ICs1ODksOCBAQCBpbnQgbWFpbigpCiAKICAgICB0
ZXN0X2RwbXB5c3Nfcm5kX3MwKCk7CiAKKyAgICBjaGVja19zdG9yZV9pbW0oKTsKKwogICAgIHB1
dHMoZXJyID8gIkZBSUwiIDogIlBBU1MiKTsKICAgICByZXR1cm4gZXJyOwogfQotLSAKMi4zNC4x
Cgo=

