Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E44FCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7Ts-0001uS-Un; Mon, 12 Oct 2026 00:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tn-0001sr-3F
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tj-000173-6z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lORN328415
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hrvRuiI+Aax3aExeBtrr/0C+zMrIpRwVMlkXuSAEd1s=; b=QHHoeS9VOCB9U5EK
 JipwCzVMIWmk0X4uYSSHYOTupp24c6gqlVZtip4rMXSl2tdqn/1vGc39SWYxGDfh
 zJ2gowiVmh40tRIP2tJVMcL1WxuLnrsNlm2Wf/dN1GDMBw8fgbDvw2LRHiH2wLJN
 TcmMMA6yVsL6OU9OUK8TayhRx4m0s4VWeyDG/4kdHsZoEGoSi3HB3sSuah/h9muh
 R3nYEWaVlYdUh3Kb/Ro7DTYbIqMhXnGL3M3crYgnlOUYol6KQyWbWJoXCJ/bXCHh
 8vSRuofxcJQpqLM7cgZ+2aJ21BNRRtye38atoTmwrrccKfJVkUSWNLmkIMcsnfTE
 O+dBFw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4ech8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359d11365bfso2579295eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778648; x=1792383448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hrvRuiI+Aax3aExeBtrr/0C+zMrIpRwVMlkXuSAEd1s=;
 b=T9hdq5LtAWOhJYqOr1KNyFfKcpeuGcxCi4KKPJJ5ERDWGNZ4mxiaMGCEhl33fLu+oQ
 acoxshZM+B2gHj4umNtzDHd3lAGoFD/GACoNbVrb4QpiksxGoNN7b5y/foTWBIxx4dZO
 bndCyb/mQrmKLGkjYrVIe2TzeEU6TVVNbERFwQz3+5L2Ao3HXm3WiYWS9Vr4PEPTwdP8
 EKPnUTmOwXd+kfIiHvbYFFMCxbLTEuOTU2YQ+uXVXDXiXplzhR/Hp9Tg4hqNCBuWa0ed
 iYAZ+e8/VoQzwp895bDskaDvYnTzrxbBXNHqVYRK04B0CShcXrstgzm/jRMePYLn2/Ba
 AaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778648; x=1792383448;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hrvRuiI+Aax3aExeBtrr/0C+zMrIpRwVMlkXuSAEd1s=;
 b=PAEMQDmN62hztTOwVIhvK79s2vIEqlJsZqTzDA/XNd1nfeNEifxegS7RL8xPWRT58z
 APS8ch5pave7hX+/mb4dwJzCLmEP+lsk8fZOGHIo6r/N1XV3tENVQZ8h1RyhFO5i1QEx
 OJwUtP+vBfHFE3loAD87zqTORW/xEODxlCMje/rEnbqoUCNwb+CQ1y4/CJ+DGc/IC/qh
 bIC607lTgGf7Xd6XNW9RGNtCrew+PlMo//sDSN21bwxvcoPO53KQy3XRmxMbb1i4H043
 IRNpg1BTR2Yk6+8NzQfwE6FRzcCsM9HWQ61Cq5FBiQCUgpe5E89BkuXos9yYnSJvMdhb
 lw9g==
X-Gm-Message-State: AFq9FYJogmtLx3wOSGAAF7TXserZUK/YNAjPiIYgxfmoO836hVBpRvOM
 Gk/wDbg/JdljuUVTCnjvPZSHRtUU6T0fa8npKq1lkAVEHynsKu0uTFKy1oaFsPqqQ3U0jLPaswn
 ph0lKUvALVeWoG5B6xQcKR30/u/5tr1Q0ftQzNzuFgSy6qfHP137UwW0+hIIz9PK3NQ==
X-Gm-Gg: AYBFou26BfKrvXGJKBD7ibHEUunrf5Z0b/p4PzfGwQdPdxwuSlBwhZE2ByYeSsrWxRW
 xnOsWnzmE5IbRZpu4g7lMXpSneOcXXpK1dxdRNSqS+cSORc9u1NuFjG8aiIbOqC8Mm346E4BZqQ
 V9cbzx1XboiNQVALtfWLsVxAIj3n9NFU/DfJzP+QLe7jFjxBw+vLTpkKkMFEfdQD0wbzFZT5p/T
 XcBDFSuGMzLaumLzVCHYS4ApjlH5Mxqrhf+YQ/TeUKLUqsMPYVQos4zkNb8JOYkStl40WqUSRsd
 3McvzZLpS2yurYuKtB19z1vsGzfCnOcBYoLxS2F7cJuEcZT72Ynszu5Cd6TV8xsTrxfheL9dAg8
 K931zQCb/wjdyGvckm4H0x5bJqIyPPfZwlnMNHClEJO068F4=
X-Received: by 2002:a05:693c:408c:b0:358:38b4:ecc2 with SMTP id
 5a478bee46e88-35838b4ee1dmr10330869eec.41.1791778647690; 
 Sun, 11 Oct 2026 21:17:27 -0700 (PDT)
X-Received: by 2002:a05:693c:408c:b0:358:38b4:ecc2 with SMTP id
 5a478bee46e88-35838b4ee1dmr10330838eec.41.1791778647125; 
 Sun, 11 Oct 2026 21:17:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PULL 01/25] target/hexagon: pass the packet PC to lock
 implementations
Date: Sun, 11 Oct 2026 21:16:58 -0700
Message-Id: <20261012041722.1159355-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX8rYZwxsxv5ge
 xcED4CkfKrDiQivO/kRexT79U9zV1F4lt5geQGMKEWxPI1+tZ6ydfzjUS45Z4Lml/S1gsBSdjfs
 a6bUT6H+l0QY0TP1Z2r0SxRfa2PpFmRV9+fP5UirkMaIVcEMBWVk2/CGXWIV3k30Svhxx0bWjFK
 T0Qi3S68yEyaRWpi2GDnzqi9LHh+PZ0U+3W/Iry3uBsK3ecY+52IVrGuUS8dpbjEOR4W8I+N/1/
 SvpHLBCa8+6AXsuudJGKAlZrQQ2r4gbMBG/QTT89MDpfWmGqsnB4ElzWKIorpWkPc26XTKfoVGw
 CQRnoRnK38OJ0GdGpVYV3Vai96YyCOpD88XO16I3w/BsXLGQgsxPb+i0L8bnZFvydQKbKYH8riM
 5bbvC3TEd2iosmQfAt3KYCW4GqHo1ptr24PqFH2t5raijRyX8KXoVbfGzjrX+5hK7gPgwH19BS3
 kswQ9JqsDa4GrLbB9oQ==
X-Proofpoint-ORIG-GUID: Bg4bxmcXVdeONYHNVBUtGb3nCHnCIG-0
X-Proofpoint-GUID: Bg4bxmcXVdeONYHNVBUtGb3nCHnCIG-0
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acc5f58 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=mWocMZdqMPi0kNrwBuIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX/DOQa2eHBVUe
 LgvqxAm9PXdsRyGLwZkkhs3Ne0zrKZKVPsaAMh/5JK809cfAPdt83SBkLMlcNwdezylYGQhBNH+
 ysMmRNeQdAGvtrAxWjhAMkkp0A4VSpU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

SGFuZCB0aGUgazBsb2NrL3RsYmxvY2sgbG9jayBpbXBsZW1lbnRhdGlvbiBmdW5jdGlvbnMgdGhl
IHBhY2tldCBQQyBhcyBhCmNvbnN0YW50IGluc3RlYWQgb2YgcmVseWluZyBvbiBuZXh0X1BDJ3Mg
b3Bjb2RlLWRlcGVuZGVudCBzdGFnaW5nLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhf
bW11LmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oIHwgIDQgKystLQog
dGFyZ2V0L2hleGFnb24vaGV4X21tdS5jICAgIHwgMTYgKysrKysrKysrLS0tLS0tLQogdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMgIHwgMTYgKysrKysrKysrLS0tLS0tLQogNCBmaWxlcyBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9oZXhfbW11LmggYi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmgKaW5kZXggNTZi
MmM0YTg5ZDAuLjk3N2E5N2RhMzFhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11
LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5oCkBAIC0yMiw3ICsyMiw3IEBAIGV4dGVy
biBib29sIGhleF90bGJfZmluZF9tYXRjaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
VkEsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgKnNpemUsIGludDMy
X3QgKmV4Y3AsIGludCBtbXVfaWR4KTsKIGV4dGVybiBpbnQgaGV4X3RsYl9jaGVja19vdmVybGFw
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50NjRfdCBlbnRyeSwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQ2NF90IGluZGV4KTsKLWV4dGVybiB2b2lkIGhleF90bGJfbG9j
ayhDUFVIZXhhZ29uU3RhdGUgKmVudik7CitleHRlcm4gdm9pZCBoZXhfdGxiX2xvY2soQ1BVSGV4
YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFBDKTsKIGV4dGVybiB2b2lkIGhleF90bGJfdW5sb2Nr
KENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHZvaWQgZHVtcF9tbXUoTW9uaXRvckhNUCAqaG1wLCBD
UFVIZXhhZ29uU3RhdGUgKmVudik7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaAppbmRleCBhNWI5Yjdm
MjU5Mi4uNzIxNzlkNDlhYjMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3Mu
aAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTE0NSwxMCArMTQ1LDEwIEBA
CiAjZGVmaW5lIGZEQ0lOVklEWChSRUcpCiAjZGVmaW5lIGZEQ0lOVkEoUkVHKSBkbyB7IFJFRyA9
IFJFRzsgfSB3aGlsZSAoMCkgLyogTm90aGluZyB0byBkbyBpbiBxZW11ICovCiAKLSNkZWZpbmUg
ZlNFVF9UTEJfTE9DSygpICAgICAgIGhleF90bGJfbG9jayhlbnYpOworI2RlZmluZSBmU0VUX1RM
Ql9MT0NLKCkgICAgICAgaGV4X3RsYl9sb2NrKGVudiwgUEMpOwogI2RlZmluZSBmQ0xFQVJfVExC
X0xPQ0soKSAgICAgaGV4X3RsYl91bmxvY2soZW52KTsKIAotI2RlZmluZSBmU0VUX0swX0xPQ0so
KSAgICAgICAgaGV4X2swX2xvY2soZW52KTsKKyNkZWZpbmUgZlNFVF9LMF9MT0NLKCkgICAgICAg
IGhleF9rMF9sb2NrKGVudiwgUEMpOwogI2RlZmluZSBmQ0xFQVJfSzBfTE9DSygpICAgICAgaGV4
X2swX3VubG9jayhlbnYpOwogCiAjZGVmaW5lIGZUTEJfSURYTUFTSyhJTkRFWCkgXApkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5j
CmluZGV4IGQ2ZWU3YzQwNzk4Li5hOGU0ZDdmMmM1ZSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X21tdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwpAQCAtMTU2LDcgKzE1
Niw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwcmludF90aHJlYWRfc3RhdGVzKGNvbnN0IGNoYXIg
KnN0cikKICAgICB9CiB9CiAKLXZvaWQgaGV4X3RsYl9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52
KQordm9pZCBoZXhfdGxiX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFBDKQog
ewogICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19NTVUsICJoZXhfdGxiX2xvY2s6ICIgVEFSR0VU
X0ZNVF9sZCAiXG4iLAogICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CkBAIC0xNzAs
NyArMTcwLDYgQEAgdm9pZCBoZXhfdGxiX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAg
dWludDhfdCB0bGJfbG9jayA9IEdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX1RMQkxPQ0ssIHN5c2Nm
Zyk7CiAgICAgaWYgKHRsYl9sb2NrKSB7CiAgICAgICAgIGlmIChlbnYtPnRsYl9sb2NrX3N0YXRl
ID09IEhFWF9MT0NLX1FVRVVFRCkgewotICAgICAgICAgICAgZW52LT5uZXh0X1BDICs9IDQ7CiAg
ICAgICAgICAgICBlbnYtPnRsYl9sb2NrX2NvdW50Kys7CiAgICAgICAgICAgICBlbnYtPnRsYl9s
b2NrX3N0YXRlID0gSEVYX0xPQ0tfT1dORVI7CiAgICAgICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxE
KGVudiwgU1lTQ0ZHX1RMQkxPQ0ssIDEpOwpAQCAtMTc4LDE5ICsxNzcsMjIgQEAgdm9pZCBoZXhf
dGxiX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgIH0KICAgICAgICAgaWYgKGVu
di0+dGxiX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfT1dORVIpIHsKICAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soQ1BVX0xPR19NTVUgfCBMT0dfR1VFU1RfRVJST1IsCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICJEb3VibGUgdGxibG9jayBhdCBQQzogMHglIiBQUkl4MzIKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIiwgdGhyZWFkIG1heSBoYW5nXG4iLAotICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnYtPm5leHRfUEMpOwotICAgICAgICAgICAgZW52LT5uZXh0X1BDICs9IDQ7Cisg
ICAgICAgICAgICAgICAgIkRvdWJsZSB0bGJsb2NrIGF0IFBDOiAweCIgVEFSR0VUX0ZNVF9seAor
ICAgICAgICAgICAgICAgICIsIHRocmVhZCBtYXkgaGFuZ1xuIiwgUEMpOwogICAgICAgICAgICAg
Q1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgICAgICAgICAgY3B1X2ludGVycnVwdChj
cywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQog
ICAgICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfV0FJVElORzsKKyAgICAgICAg
LyoKKyAgICAgICAgICogbmV4dF9QQyBoYXMgYWxyZWFkeSBiZWVuIGFkdmFuY2VkIHBhc3QgdGhp
cyBwYWNrZXQuICBSZXdpbmQgaXQKKyAgICAgICAgICogc28gdGhhdCB0aGUgdGhyZWFkIHJlLWV4
ZWN1dGVzIHRoZSB0bGJsb2NrIHdoZW4gaXQgaXMgd29rZW4gYnkKKyAgICAgICAgICogdGhlIHRo
cmVhZCB0aGF0IHJlbGVhc2VzIHRoZSBsb2NrLgorICAgICAgICAgKi8KKyAgICAgICAgZW52LT5u
ZXh0X1BDID0gUEM7CiAgICAgICAgIENQVVN0YXRlICpjcyA9IGVudl9jcHUoZW52KTsKICAgICAg
ICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKICAgICB9IGVsc2Ugewot
ICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKICAgICAgICAgZW52LT50bGJfbG9ja19jb3VudCsr
OwogICAgICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfT1dORVI7CiAgICAgICAg
IFNFVF9TWVNDRkdfRklFTEQoZW52LCBTWVNDRkdfVExCTE9DSywgMSk7CmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmlu
ZGV4IDRmMDBjYTc3M2YzLi4zZGU2Yjk5NGI4ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEyODMsNyAr
MTI4Myw3IEBAIHZvaWQgSEVMUEVSKG1vZGlmeV9zc3IpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCkKICAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBu
ZXcsIG9sZCk7CiB9CiAKLXN0YXRpYyB2b2lkIGhleF9rMF9sb2NrKENQVUhleGFnb25TdGF0ZSAq
ZW52KQorc3RhdGljIHZvaWQgaGV4X2swX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQz
Ml90IFBDKQogewogICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7CiAgICAg
Q1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwpAQCAtMTI5Nyw3ICsxMjk3LDYgQEAgc3RhdGlj
IHZvaWQgaGV4X2swX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwogICAgIGlmIChHRVRfU1lTQ0ZHX0ZJ
RUxEKFNZU0NGR19LMExPQ0ssIHN5c2NmZykpIHsKICAgICAgICAgaWYgKGVudi0+azBfbG9ja19z
dGF0ZSA9PSBIRVhfTE9DS19RVUVVRUQpIHsKLSAgICAgICAgICAgIGVudi0+bmV4dF9QQyArPSA0
OwogICAgICAgICAgICAgZW52LT5rMF9sb2NrX2NvdW50Kys7CiAgICAgICAgICAgICBlbnYtPmsw
X2xvY2tfc3RhdGUgPSBIRVhfTE9DS19PV05FUjsKICAgICAgICAgICAgIFNFVF9TWVNDRkdfRklF
TEQoZW52LCBTWVNDRkdfSzBMT0NLLCAxKTsKQEAgLTEzMDUsMTkgKzEzMDQsMjIgQEAgc3RhdGlj
IHZvaWQgaGV4X2swX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgIH0KICAgICAg
ICAgaWYgKGVudi0+azBfbG9ja19zdGF0ZSA9PSBIRVhfTE9DS19PV05FUikgewogICAgICAgICAg
ICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICJEb3VibGUgazBsb2NrIGF0IFBDOiAweCUiIFBSSXgzMgotICAgICAgICAgICAgICAgICAg
ICAgICAgICAiLCB0aHJlYWQgbWF5IGhhbmdcbiIsCi0gICAgICAgICAgICAgICAgICAgICAgICAg
IGVudi0+bmV4dF9QQyk7Ci0gICAgICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKKyAgICAgICAg
ICAgICAgICAiRG91YmxlIGswbG9jayBhdCBQQzogMHgiIFRBUkdFVF9GTVRfbHgKKyAgICAgICAg
ICAgICAgICAiLCB0aHJlYWQgbWF5IGhhbmdcbiIsIFBDKTsKICAgICAgICAgICAgIGNwdV9pbnRl
cnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7CiAgICAgICAgICAgICBjcHVfbG9vcF9leGl0
KGNzKTsKICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQogICAgICAgICBlbnYtPmswX2xv
Y2tfc3RhdGUgPSBIRVhfTE9DS19XQUlUSU5HOworICAgICAgICAvKgorICAgICAgICAgKiBuZXh0
X1BDIGhhcyBhbHJlYWR5IGJlZW4gYWR2YW5jZWQgcGFzdCB0aGlzIHBhY2tldC4gIFJld2luZCBp
dAorICAgICAgICAgKiBzbyB0aGF0IHRoZSB0aHJlYWQgcmUtZXhlY3V0ZXMgdGhlIGswbG9jayB3
aGVuIGl0IGlzIHdva2VuIGJ5CisgICAgICAgICAqIHRoZSB0aHJlYWQgdGhhdCByZWxlYXNlcyB0
aGUgbG9jay4KKyAgICAgICAgICovCisgICAgICAgIGVudi0+bmV4dF9QQyA9IFBDOwogICAgICAg
ICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwogICAgICAgICBjcHVfbG9v
cF9leGl0KGNzKTsKICAgICB9IGVsc2UgewotICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKICAg
ICAgICAgZW52LT5rMF9sb2NrX2NvdW50Kys7CiAgICAgICAgIGVudi0+azBfbG9ja19zdGF0ZSA9
IEhFWF9MT0NLX09XTkVSOwogICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxEKGVudiwgU1lTQ0ZHX0sw
TE9DSywgMSk7Ci0tIAoyLjM0LjEKCg==

