Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258FFC43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3dh-0002v4-Rx; Mon, 29 Jun 2026 00:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3d1-0002d6-Nx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3cw-0000jW-Gg
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NKSw1781034
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=; b=jN7VJLB5Sa7CzS52
 iIkjDxgMkSKaGQMLUmBYd9XjMI1pwhw6gd5pXVhBQtQudoG8BgOeZNHQ6fTZgEh0
 CT1PSmATn3MMWXOuTBj2mPm8h6Mpl7pES0iFRRIQ9ZY59chWHskf00myRcR1tMFt
 artP2XoGtXzYCsxRc+hicw6umgrC9vINdZwJRLd94UF9wC1bcJd7alof3Z58uQxg
 7/mrLDOLdYXienLzu3HLgBlwp6lDuOY8DWbB2nDgqWp+xebNuDiEIlCBDcb1fZ0P
 Rclij6ZGbCbwbO7AXMuI/c4qNvORIzvmEhJPI8bITZQ+2k+l/uvYc5iJzsH+uvaq
 UOERlg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74ghb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c9bd8b9c7so3409403eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707384; x=1783312184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=B9Wa7Ofz8wR0IbjkWQGChjaxyO4lJDRAiRRldDKFNL7SMe1+v07QqhWAxRVaOj7FPu
 HLUWnzv5xRvAmLyY8yq535yeF3ZdVXYEL5WHp97FehaqC2vDbZC+xvdQNmUpcf/p3ziK
 D+1ZT7TmB3iyNF+yTB3pvsipNB1gi7Nm5CRHmwE57pYKCUMm1iEIhSyOtGz/GdldCyN1
 DRwy+DrAqYWBqfkRvRe9wyNNe0V4RryK3AAOtZc8soYmMUqnK5VvfDb6YRcJFEsmrYX1
 BXMqEnQGs6xQHaNwkpqcnQs0vgDckbDka1BJQAbKNAmceZWEibQxClLvNhJ8wYwoccNT
 NTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707384; x=1783312184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=VCV9ZlYMrjcRUdN0m4ZJGK5rI0A4uzI9z5muCI5KMTSouzLjg7CtY95OQeingpcr40
 NpSGgNOMZda6zdC+6rrVoiuWgJb06ISXXHk+JbluwVnvABRK3U4jMaxWalNb55aVJ6b6
 nT6bhZxBwedZEt2ZqKvg7a0q2Yyi8QJBGlNfqBjrMcyhEmMdMTfyjh81hwYKz+/7gcr4
 P8EV88Hqsdur4D5UtHapBzQtrL92386IkTL3+D+dQnc6qxgVBSQwV4LDmUP7y4aeX9Vb
 4To8sahznEmityEWWbdQDEbkhfUVod4ns9SdI9zux+Yq+2GTHj5I9H6J7zz7qAhgJ7+F
 NUHQ==
X-Gm-Message-State: AOJu0Yz7VLgNp27aYC5bZsfvw2++nX2sYXd/n+ru+J6MwK8T6rNVJ6U4
 xCSJEx471b5jXlvkYusfIaieHJJmTc44mzLpBLdgHgjOU+VABGsEUWk9Nhmm9aG5/K9MLGf+Yfj
 dvBUUqldoCTKYbThbuwOE6AEaF/8ZXKhQyc1/MiKHyeEAWNm0W+1QfQBHrp/3rg6TJQ==
X-Gm-Gg: AfdE7cnMUVOLcKhm//p7I86+gGEbupXvvbPQFhm1xbAYJPqNmqSpb2s2wnQsnSITnin
 ONUzYP0/pnlf2Kk4ejbVWfsUWmB/gg60Q0AszibKQV6G74rnUJaXmtWyGZn2mMWyN8A3Gb8/coV
 cM8fghC3go992ve6dcm/lZn7wNMt7YcixdbTw/EeFdnwryt7wRkiv7nRW2f75xV5yDCyR+lcfMU
 l0Fnsd4pFtPw0L+G561EpCzGvLvsWHQpaPqUjYHKbPse+2c8tVKq3rYq64V6R01q1WRKp6TdnH4
 EeCfKdja9utyB0jas+vSoHQz/lrWA9zLhHXUGyLeo983N04rSwm1I2GkVuaoa4kzZQ/lx9sZV7P
 3i7fdi7yLebQ4fZ9ZbP+MYyS31GDftCeoIIO00kCtcAKKh4PVqq6e7jku9T8=
X-Received: by 2002:a05:7301:5f14:b0:2f7:d419:dee0 with SMTP id
 5a478bee46e88-30c84d127d9mr12856421eec.6.1782707384254; 
 Sun, 28 Jun 2026 21:29:44 -0700 (PDT)
X-Received: by 2002:a05:7301:5f14:b0:2f7:d419:dee0 with SMTP id
 5a478bee46e88-30c84d127d9mr12856399eec.6.1782707383652; 
 Sun, 28 Jun 2026 21:29:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 43/77] target/hexagon: Implement start/stop helpers,
 soft reset
Date: Sun, 28 Jun 2026 20:57:56 -0700
Message-Id: <20260629035830.1520296-44-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX2v6Mq/33B+4T
 v/5Jp1StXWRC+q3W5CDno/0PXXQ9bVr/x8tUi92iS5qAAJ3w6zNNafdUFoIoMiP1JZl27gNYbit
 F4GIdP7c0U0ewgnCAoyAPtkE/1J35Ys=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41f4b9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mCWuZxMSpaUKZHDxuVkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SiNb-TI8ZAacHFH9tn5cZBLgXLKbT4Pr
X-Proofpoint-ORIG-GUID: SiNb-TI8ZAacHFH9tn5cZBLgXLKbT4Pr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX1fgePX7V9AtD
 2lnurxO97YK8fuBOdsVlIJSyw5rdZfBGbuiVg0IbiYUn70p2yjUbb+Aalq3CInVOCQArXpLHpy+
 nOGLYNiFMmE70MOLAWndSIfm8sArpCkhddSMX2RiflHrxoFYT/z3p9jUmR+wsZ2uuIlFD1TsJNn
 4atKMKDNTohY2mYfh6YhGS/fpK0E5Xw5fSA3UCJ9FDHJsmSui5LSJO3rcHT9EcRvlBkYG93YIIx
 wG5G4Sa/JtbWRGRnICv3XY/2ysQ5uIT7P9+kZe+TdVqmHJV6GGa+0n1KbjVYAtTcC4Sim+3u97M
 gpiof8+m9RwruCXC4eSNHMyfNTgB7AfepiJEYhZmNJu0reHSgpREH14t9QF/oLZw0uljgDopNYb
 gHvro6x+kjpM8qfBsN1b7qA5QISN/m+QApyKnHqbLfktRnhs9efuJ2qktQa4S5eW3cZ3lCF5Xqa
 OyVJzjPzAVh6EPagLoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vY3B1LmggICAgICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5j
ICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJn
ZXQvaGV4YWdvbi9jcHUuaAppbmRleCAxYjIyNWUzNWFiYy4uOTJkNGJiOTcxMjkgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0y
MTMsNiArMjEzLDE1IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9l
cnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludHB0cl90IHBjKTsKIAorI2lmbmRlZiBDT05GSUdfVVNF
Ul9PTkxZCisvKgorICogQHJldHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJl
IHRocmVhZCBpcworICogbm90IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNf
ZW5hYmxlZChDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYpOwordm9pZCBoZXhhZ29uX2NwdV9z
b2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0ZSAqZW52KTsKKyNlbmRpZgorCiB0eXBlZGVmIEhleGFn
b25DUFUgQXJjaENQVTsKIAogdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpOwpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRl
eCBlYjFmNzA0OTI5OC4uMjdmMGVmNTBkZjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0zMyw2ICszMyw3IEBACiAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKICNpbmNsdWRlICJzeXNfbWFjcm9zLmgiCiAjaW5jbHVkZSAiYWNj
ZWwvdGNnL2NwdS1sZHN0LmgiCisjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKICNlbmRpZgog
CiBzdGF0aWMgT2JqZWN0Q2xhc3MgKmhleGFnb25fY3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hh
ciAqY3B1X21vZGVsKQpAQCAtMzEwLDYgKzMxMSwyOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3Jl
c3RvcmVfc3RhdGVfdG9fb3BjKENQVVN0YXRlICpjcywKIH0KIAogCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKK3ZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVIZXhhZ29uU3RhdGUgKmVu
dikKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHU7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAg
IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl0gPSAwOworICAgIGhleGFnb25fc3NyX3NldF9jYXVz
ZShlbnYsIEhFWF9DQVVTRV9SRVNFVCk7CisKKyAgICBjcHUgPSBlbnZfYXJjaGNwdShlbnYpOwor
ICAgIGlmIChjcHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgdWludDMyX3QgZXZiID0KKyAgICAg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19F
VkIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOwor
ICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGV2YjsKKyAgICB9IGVsc2UgeworICAgICAg
ICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworICAgIH0KK30KKyNlbmRp
ZgorCisKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJl
c2V0VHlwZSB0eXBlKQogewogICAgIENQVVN0YXRlICpjcyA9IENQVShvYmopOwpAQCAtMzM5LDkg
KzM2MiwxMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKIAogICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0hUSURdID0gY3B1
LT5odGlkOwogICAgIGVudi0+dGhyZWFkSWQgPSBjcHUtPmh0aWQ7Ci0gICAgZW52LT5ncHJbSEVY
X1JFR19QQ10gPSBjcHUtPmJvb3RfYWRkcjsKLSNlbmRpZgorICAgIGhleGFnb25fY3B1X3NvZnRf
cmVzZXQoZW52KTsKICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKKyAgICBl
bnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworI2VuZGlmCiB9CiAKIHN0YXRp
YyB2b2lkIGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvKGNvbnN0IENQVVN0YXRlICpjcywKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMKaW5kZXggNmYwMWYzYjkxZDguLmI5Y2YxZjE4OGJiIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtMTQ3OSwxMiArMTQ3OSwxMiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAKIHZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgaW1hc2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICBoZXhhZ29uX3N0YXJ0X3RocmVhZHMoZW52LCBpbWFzayk7CiB9CiAKIHZvaWQg
SEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQogewotICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CisgICAgaGV4YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCiB2b2lkIEhFTFBF
Uih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQotLSAKMi4zNC4x
Cgo=

