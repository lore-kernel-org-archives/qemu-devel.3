Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A07606A8AF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gB/haaOE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JyFG+EWa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTE1-0005yX-P9; Fri, 20 Nov 2026 13:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE0-0005yO-N8
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTDy-0000GG-K2
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:40 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKGFsvm3830196
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZWzaegTczRZLVWvdsi8d/1D+lGgmlfY9Ir5jqzLeBFA=; b=gB/haaOEwE6Wb+VW
 cb/gDLnZkzyuAsNAeTuPlEps5Talh8CIwpeJSY2DyesHhEdTuH+JkkEoExqNVX55
 8GG8GfPXagTjt5SF878vSzxjCW7vPk4x5cvxm0LJdmum69ug1CqIPuKkOkuYNCEo
 KpnuBPSoK3JK/6ExRGyPe06OGaqMfwzE3Qcn4Ukzpjj+AW7bOUavcdPdMHrSk5Dm
 MqehCk4b27fgxO7jMSfB9815kUESeWmE+e6XPM67wvowY3LkGW2EjMGKkKz36DBo
 A7be7BUixw+v9fzuqOBvzVBxcmJiAqmamcjroT76knvEbwXgtf5T8jFM+Ku5e/1+
 jkb8Rw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2sjwgmca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:35 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-85c1135c289so974450a34.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198835; x=1795803635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZWzaegTczRZLVWvdsi8d/1D+lGgmlfY9Ir5jqzLeBFA=;
 b=JyFG+EWavYwrWyWhPXRr6chE8WruKKjYclBxd4n0iFiDUn1cPHJugywD30x/o6PMDd
 5/t2nSIE/npLGzYsyRSw1nnGjU4gMgnkU48Wsg68CAjoyqiNZNo5J5wz9SG2Jy7CPuq7
 bVSL483zXPi2mxtA9DbVGcaDjGB9xgymGhyrJfNwWWqSkH5Ee36YgyDs7vl1DT95jplf
 +vQ8IqTait6KcRAM50WX832lb73egQMMy7LfvmTlrgDxOKn1ynvmfEItV39q4QBNsfJg
 vOL2tBmg+mLwbAEmbBU8m7YpuBgexdnChBaf+96VB+PT1VeXgxctCd88Xjjvgf2M2Y6L
 AdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198835; x=1795803635;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZWzaegTczRZLVWvdsi8d/1D+lGgmlfY9Ir5jqzLeBFA=;
 b=vHDXAx5F17+7EQ1/gPGt+waTvk422vDRhtKzZtiIQ9RieoO4+UFsppJBx+5i4gXZOP
 QepVPLjsBl86QmOdILJRtZ0jcfpJuAqYbeGAm30TEj0XjDKdBp3k6KzJhkzPaP+GfBE0
 Vsp+hpphShhHqicCKeppNMTlhaZY7MC2/dBsTfa0uwTfuGpYFeQpEt0GmfGVWcXt3PLo
 l+hBmRRUIkA22aQdQNeT4XuNofW1t4DSMdl6Ogb7AzwTAn8Ypgj7b199GJoaZxf/0Foq
 K7NCu7TKwtkEzqMtRo0QqkTqhZ5hQwkmpVsE87YS5Io3PFLASzG5fhPyHEQ6gJRttFHC
 1BnA==
X-Gm-Message-State: APuU4Z+kSsRikXzVbV+uGqTvMYZtErgvXJWDO9o2evnlTilIr4EuSUsl
 j57UUsTtkHaWxu/qYctk8xR3QFEWWqB2s7uvj9cCbpy7w51PXJK35BwRIb8dvDCOFAi1eOHIhSt
 zSFINouOLxDRMl03o8+H+qbWLprtjnv0zOE9ZEyImd6cGqGQsn4E0q1bTBfiqQhiKUA==
X-Gm-Gg: AYBFou1RFvlykviqFBWZSoJuy1rtW0EIZOOzWC0BwTvlGDEvnuaadHh5iEW2VhmWWrr
 zv7kS4n3+9j8A/zZshO+6zu6OJ/A2qqmcu9Ss5+65RcItl2nhcMDOk+NhZxjzBKV4uZrpYM/ZXJ
 LzByEocJ90jaHqB++w1yk0WzNbdFa2TvH8A1qwsy45FxHrdmBWfv2dBsv3zpCpDmo0WjB7hd1/r
 Wi8GfdjmZGU3JTK/kZYIcNdnDy7JEsqTHAWyQV9XTQtoU962z09rP/eALPuR01sH9rLH2h5dXUJ
 ObwDOzsZMdsHZrKoemqibhdexaEevRIQ5alrhQbllLzIVZEWIJpREinNzR7k6Jfb3GMehf8RGNO
 Fd38vcsnLJ/+2LEmxFo1LFqJz+rbTK7ZNDtaHrAaWWpiKovz5YNNVbHj5SeIIvVs+GCTyTQVcER
 +lImKex1yImEUuC/qGnu5meA==
X-Received: by 2002:a05:6830:348e:b0:81e:abb6:749f with SMTP id
 46e09a7af769-86315490d2emr4639309a34.8.1795198834981; 
 Fri, 20 Nov 2026 10:20:34 -0800 (PST)
X-Received: by 2002:a05:6830:348e:b0:81e:abb6:749f with SMTP id
 46e09a7af769-86315490d2emr4639277a34.8.1795198834504; 
 Fri, 20 Nov 2026 10:20:34 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:33 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v2 01/12] target/hexagon: read the old predicate
 value through C4
Date: Fri, 20 Nov 2026 10:20:20 -0800
Message-Id: <20261120182031.560481-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 4JF8b35KvVPHSsAWd_FrfC2PX_gMnKLW
X-Proofpoint-GUID: 4JF8b35KvVPHSsAWd_FrfC2PX_gMnKLW
X-Authority-Analysis: v=2.4 cv=dZ4VTnXe c=1 sm=1 tr=0 ts=6b008f73 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9fZTsBWXyneHJwdpUA4A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX9yrapSX5pV0t
 dcKVRIdSWGlum17n+uhmGG31/hsyFC8M6l8fHuVK/9g/nVf9X4v2wCEBBQEoT33B70a9+B7o3K1
 LKDSViiFlxS20Akm6cvYdMGuumV80FM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX8TeOP4/RcIn8
 93t7zemZ4bzZaED1dQCTvE7wcm0BlNrTl1AiSzY53/L2yX1enfIJfv5ZCII+vUX8itTPhUI7nx8
 uRTDBhTc8qA2IDP4lDgon78FuHpzbv2HyN4W7mZCNpNdlSYctTZY26/sd53bC0vvG6vne3kBGJk
 koHDhkMPZQBIhyZ5V8xCo4hBOPCnDyx7uc40KcI8ILO6CWTKrDRPzw/3PETkEgeH5fGgMZm2k0O
 c1Z5FWQmZLisY8zhaDJAxrN40EQWg2v37btdqUCz0GGZTZwylx/HfzeNquicLWmE+Saj3Ly0URZ
 8m+wuyGxa0NrdBIjTtY2Exe1oUUwA1ShP8XcY1Nsqn9sahd0bvbY5JHcIZOtTXot1PcLnJkltVG
 A2p2PLs/e8F5+4wxwhfIpi1rE1p7xwLT33wiqfAZkXZwvm/vo/uaJkrOpwYAY7GTOrcMuVRr6I2
 288y9hCFBxYBo7VNaSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClRyYWNr
IEM0IHJlYWRzIGFzIHJlYWRzIG9mIGFsbCBmb3VyIHByZWRpY2F0ZXMuIFRoaXMgcHJldmVudHMg
dGhlCnBhY2tldCBzaG9ydCBjaXJjdWl0IGZyb20gZXhwb3NpbmcgYSBwcmVkaWNhdGUgcmVzdWx0
IHRvIGFuIG9sZC12YWx1ZQpjb250cm9sIHJlZ2lzdGVyIHJlYWQuCgpTaWduZWQtb2ZmLWJ5OiBN
YXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICB8ICA2ICsrKysrLQogdGVzdHMvdGNnL2hleGFn
b24vcGFja2V0X3VzZXIuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
dGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwg
NDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rz
L3RjZy9oZXhhZ29uL3BhY2tldF91c2VyLmMKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IGJjM2I0OWFiMDZk
Li5jOTg4Yzg1ZjMzYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTI0OCw3ICsyNDgsMTEgQEAgc3RhdGlj
IGlubGluZSB2b2lkIGN0eF9sb2dfcmVnX3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGlu
dCBybnVtLAogCiBzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19yZWdfcmVhZChEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHJudW0pCiB7Ci0gICAgaWYgKHRlc3RfYml0KHJudW0sIGN0eC0+cmVnc193
cml0dGVuKSkgeworICAgIGlmIChybnVtID09IEhFWF9SRUdfUDNfMF9BTElBU0VEKSB7CisgICAg
ICAgIGZvciAoaW50IGkgPSAwOyBpIDwgTlVNX1BSRUdTOyBpKyspIHsKKyAgICAgICAgICAgIGN0
eF9sb2dfcHJlZF9yZWFkKGN0eCwgaSk7CisgICAgICAgIH0KKyAgICB9IGVsc2UgaWYgKHRlc3Rf
Yml0KHJudW0sIGN0eC0+cmVnc193cml0dGVuKSkgewogICAgICAgICBjdHgtPnJlYWRfYWZ0ZXJf
d3JpdGUgPSB0cnVlOwogICAgIH0KIH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Bh
Y2tldF91c2VyLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9wYWNrZXRfdXNlci5jCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5hY2M3NzIwMmVmMwotLS0gL2Rldi9udWxsCisr
KyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3BhY2tldF91c2VyLmMKQEAgLTAsMCArMSwzOCBAQAorLyoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEJTRC0zLUNsYXVzZS1D
bGVhcgorICovCisKKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5oPgorCitz
dGF0aWMgaW50IGVycjsKKworI2luY2x1ZGUgImhleF90ZXN0LmgiCisKK3N0YXRpYyB2b2lkIHRl
c3RfcHJlZGljYXRlX3JlYWQodm9pZCkKK3sKKyAgICB1bnNpZ25lZCBvbGQsIG5ldzsKKworICAg
IGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzB4MTJcbiIKKyAgICAgICAgInAzOjAgPSBy
MFxuIgorICAgICAgICAie1xuIgorICAgICAgICAiICAgIHAwID0gY21wLmVxKHIwLHIwKVxuIgor
ICAgICAgICAiICAgICVbb2xkXSA9IHAzOjBcbiIKKyAgICAgICAgIn1cbiIKKyAgICAgICAgIiVb
bmV3XSA9IHAzOjBcbiIKKyAgICAgICAgOiBbb2xkXSAiPXIiKG9sZCksIFtuZXddICI9ciIobmV3
KQorICAgICAgICA6IDogInIwIiwgInAwIiwgInAxIiwgInAyIiwgInAzIgorICAgICk7CisgICAg
LyogUGFja2V0IHJlYWRzIG9sZCBDNCwgdGhlbiBjb21taXRzIFAwLiAqLworICAgIGNoZWNrMzIo
b2xkLCAweDEyKTsKKyAgICBjaGVjazMyKG5ldywgMHhmZik7Cit9CisKK2ludCBtYWluKHZvaWQp
Cit7CisgICAgdGVzdF9wcmVkaWNhdGVfcmVhZCgpOworICAgIHB1dHMoZXJyID8gIkZBSUwiIDog
IlBBU1MiKTsKKyAgICByZXR1cm4gZXJyICE9IDA7Cit9CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cv
aGV4YWdvbi9tZXNvbi5idWlsZCBiL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4
IDcwZjY0NzU2NTZjLi5iMzYzNWJlM2ZjYiAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24v
bWVzb24uYnVpbGQKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTk2LDYg
Kzk2LDcgQEAgdGVzdHMgKz0gewogICAnbWlzYy5jJzogeydjZmxhZ3MnOiBbY2ZsYWdzLCAnLW12
NzEnLCAnLU8yJ119LAogICAnbXVsdGlwbGUtd3JpdGVzLmMnOiB7J2NmbGFncyc6IFtjZmxhZ3Ms
ICctbWh2eCddfSwKICAgJ292ZXJmbG93LmMnOiB7J2NmbGFncyc6IGNmbGFncywgJ2V4ZV9uYW1l
JzogJ2hleC1vdmVyZmxvdyd9LAorICAncGFja2V0X3VzZXIuYyc6IHsnY2ZsYWdzJzogW2NmbGFn
cywgJy1PMiddfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKICAgJ2R1
YWxfc3RvcmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdmcmFtZWtleS5jJzogeydjZmxh
Z3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

