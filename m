Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA874606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pN4bkn3K;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g4g7PUVX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW18-0003Yf-Qp; Mon, 09 Nov 2026 15:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0a-0003NY-Ad
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:31 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0W-0007Hr-Eg
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:28 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHLPJ562083
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yT8//N0GY+gttz42XYGIjhvStSZfx8rCAyqLX7JU1/c=; b=pN4bkn3KqFpH6oOf
 ofKgp9HaiQf8BsPSm6HB1LFFEnlXsey6deA3WNBhNYWxoQ0WUvYuTYMUjX+NfMlv
 HkZeTa3Jg0WrlYQiIiVmafWBOlDdCvdZCoY35gL0XMh9V7qtdihzhV02tqgfzteR
 ehWpZhxnKZ/9WeFJuS2SQdjWxk7epCgD2VlWIOdrfapNGyJZ12KvBCvxHN05kc/i
 CiddyQGk30OgUXKXTME9KV9yqLrTzWFYzWRnXZDwyiVfFw6eSZJURZTX2Z81drN/
 XnYM8UaBeqcEPVu3CeIwbfGvZT87dCjdwcvHAX7SJ4gw3Y69h0/kv/hyAQNuXPkc
 ykV9Bw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydj2yc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:30:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so2229247eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256221; x=1794861021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yT8//N0GY+gttz42XYGIjhvStSZfx8rCAyqLX7JU1/c=;
 b=g4g7PUVXbEpfVmmMCNclOq0nHvoHM39nq4JO2IzNSjH4APxemhgKvHwjc74boevDGR
 jCL2W5afTzY6YKIwQk3hLWu3QXiBPtzB6AQLx8al5sWIOwLx96pzByCn/dwvaLcSLqYg
 LJbxM98YAxqMmN5h+B3EsPTKelcXAk9Xn4iZvX9cTk3HKbD52kdUBKINP3Wh9m1fA8cs
 d7f22EYKpQM76hQ1JtpXhFDmIDlRTNYGZniaLShmg3bgfQYwkh+U3Cx0UiA9TY8h0cd0
 1CT9v406lng+IKtGa4f5K2a4kxtmifKIbmuessm6ThK+rBdWk4irh3BTyP5TxffcVsKv
 UYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256221; x=1794861021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yT8//N0GY+gttz42XYGIjhvStSZfx8rCAyqLX7JU1/c=;
 b=Q+VJbQyc5LkA9uNmiyd6W3lLtKfUNuKn34IX5Kcnb0H/yfopyyEa+0gxccDPs2p9vY
 xx/4rD1xDiPP9Ph8qYrhZa6skRFsi0I6+dy45BcUU0i5SdSaq6y54KuzJwesixhISc9U
 UiydaS1rpvcIHcfLHWt8u17RDRIy/gtIhIZQ1xZ6L6kFryct/oVyOcjKXCu7qPfjvBXk
 72v4NML6kzt2EJdfaVLL0PRkxYe0h9+2ProlvCrccEKmCFRxjKWjYnOqFCZNch3d7KPo
 T2+1jve46nPG9gla5dCxdwLrABDNyryEO13JQAwTTSFLavr4dfgez6sWjkhsZiaIlD5/
 ZwQg==
X-Gm-Message-State: APuU4Z+JUZ38jwIOn/xfn4UKilMfiRXnni9HTs1GL4NnmLOnCozA2LIH
 luW58MBodJHUeJiksqy934Xacdtg1Q1Lpo2EVupyrH9pSMYdT64HxRlJWzgO/uChtesrnliO/qm
 nyZlhIIZgPRp0pGDnnzPWR9clauhpU1+rZaqOgsgD1J8NMZPa0Zht9KNjtX5rPZL4GA==
X-Gm-Gg: AYBFou0TwGgp/bnkid18MfTBOlUofRdDF7MjunaAgj3TXSmczY6IlRdegnNd1w3dr8g
 pXjSPvujJzqlIL65iwjfbQ0eAMIjvkuklK2YHVehN/TiNU7mju4KpRzhwoFzkjECOT+mFr2zBy5
 PrTBKktLwkHpvvr8oDBwtfjaldCgkFX57PWcHCZVxUrV3EL5YyRZKm6CEHsXOEsp2HrqPxRyjxt
 44WNZwU0PFjoFcS1IAr9GXU51nNN8aTBO/AD1ilGOFMFOGvISxKJXUYOevu2tYzoLstBNb1B3xU
 Wb3Op2BsfsPgjx5kWrOKIRp5qHkl6li6RklBLMRPfZmrnqzRP6/yIARUtlzf9GhIy8Tz2PBDWRu
 DjJAOdBBVednICt5liEUU8lZDiWRUs5E/89KCZKo7JXbFm+QrbeHOitoPVPTBJ5R+dJCHWDNy2z
 7M3m3LsLV9Kmdpszwmyhkn
X-Received: by 2002:a05:693c:8842:b0:36a:1f8:a589 with SMTP id
 5a478bee46e88-37520717487mr434286eec.27.1794256220869; 
 Mon, 09 Nov 2026 12:30:20 -0800 (PST)
X-Received: by 2002:a05:693c:8842:b0:36a:1f8:a589 with SMTP id
 5a478bee46e88-37520717487mr434209eec.27.1794256219890; 
 Mon, 09 Nov 2026 12:30:19 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060dc0csm823737eec.14.2026.11.09.12.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:30:19 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 1/5] docs/system/hexagon: describe machine models and
 memory maps
Date: Mon,  9 Nov 2026 12:30:13 -0800
Message-Id: <20261109203017.262225-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
References: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX4/DdIhgG7rga
 H05W3S34HtrHZkQf8MCdjxGeNDz8P7N8wjQyWlEGc3QeYBGXYuSqi2vT1Rdr2TyewiNmayWrU39
 FdvpnxRTYXs0HjNffZWtEb2IUrykIvg=
X-Proofpoint-GUID: IvLSyaLs12-S9U7_bKjCnJzsE4DZ3s8T
X-Proofpoint-ORIG-GUID: IvLSyaLs12-S9U7_bKjCnJzsE4DZ3s8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX9/AsGoJ44EmD
 469pfheJJaNOMzx2w209hDJK9i0t6nm3agGLPXXQYlyN4tl9mgIwCnjir5SYnJcSo2eZZmhzIS4
 YLzMkVbk5uC1qbz+RtunHziKBBqbWyp5yREEV0jx2F2nQwcLKn1tAidtKI+Pg9luO+KL/t3OQfM
 AczebS/rnGHAaPM2Lv9fDTQeQbCcGWUX07qBe3H2anuhXI3JG0lX7gbdYR10yMzNHC8IWe5jYlO
 KqMCZwo9BIUzaJpYraU/0JFNx4iFJmfUqRfwMF6zKG5tY4Qk8x5zfcTxNPsyusW1NjTbGrrO1e9
 XPYhjFBwhOq1r5vixqU053qdbvNs3udVPOzXrbqe82Sw/7olAykqZ8K3ExhRfc8FuhvqPw9Jj7s
 ad8RAtl/Bc8Ncid5bT/4bQKwG3JjokcNs1Nx6gM+DHEkx6TFsllwR4eSAH79P+SAHiu8r1wiTzg
 jjK8fIXAu4wR7RF1jUg==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af22d5e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=XEA1TDPqdI0cZNt5_OoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5yc3QgICAgIHwgNDEgKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vbWFjaGluZXMu
cnN0IHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRvY3Mvc3lzdGVtL3Rhcmdl
dC1oZXhhZ29uLnJzdCAgIHwgIDUgKystLQogMyBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25z
KCspLCAyNCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3N5c3RlbS9oZXhh
Z29uL21hY2hpbmVzLnJzdAoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5y
c3QgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2Nkc3AucnN0CmluZGV4IDhkM2ExZjYxMWIwLi4zNTU2
ZDhhOGFhMCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9jZHNwLnJzdAorKysgYi9k
b2NzL3N5c3RlbS9oZXhhZ29uL2Nkc3AucnN0CkBAIC0xLDIxICsxLDEyIEBACiAuLiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogCi1Db21wdXRlIERTUAotPT09PT09
PT09PT0KK0JvYXJkLXNwZWNpZmljIGJvb3QgZmlybXdhcmUKKz09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KIAotQSBIZXhhZ29uIENEU1AgaXMgZGVzaWduZWQgYXMgYSBjb21wdXRhdGlvbiBv
ZmZsb2FkIGRldmljZSBmb3IgYW4gU29DLiAgVGhlCi1gYFY2NkdfMTAyNGBgIG1hY2hpbmUgY29u
dGFpbnM6Ci0KLSogTDJWSUMgaW50ZXJydXB0IGNvbnRyb2xsZXIKLSogUVRpbWVyIHRpbWVyIGRl
dmljZQotCi1UaGlzIG1hY2hpbmUgd2lsbCBzdXBwb3J0IGFueSBIZXhhZ29uIENQVSwgYnV0IHdp
bGwgZGVmYXVsdCB0byBgYHY2NmBgLgotCi1IMiBib290IGZpcm13YXJlCi0tLS0tLS0tLS0tLS0t
LS0tCi0KLVRoZXNlIG1hY2hpbmVzIGNhbiBiZSBzdGFydGVkIHRocm91Z2ggdGhlIEgyIGh5cGVy
dmlzb3IgaW1hZ2VzIHNoaXBwZWQgaW4KLWBgcGMtYmlvc2BgLCBzZWxlY3RlZCB3aXRoIGBgLWJp
b3NgYDoKK1RoZSBDRFNQL05TUCBtYWNoaW5lcyBjYW4gdXNlIHRoZSBob3N0IGZpcm13YXJlIHNo
aXBwZWQgaW4gYGBwYy1iaW9zYGAsCitzZWxlY3RlZCB3aXRoIGBgLWJpb3NgYC4gVGhlc2UgaW1h
Z2VzIGNvbnRhaW4gSDIgYW5kIGVpdGhlciB0aGUgYGBib290ZXJgYAorb3IgYGBsb2FkbGludXhg
YCBsb2FkZXIuIFVzZSBgYC1MYGAgdG8gc3BlY2lmeSBRRU1VJ3MgZmlybXdhcmUgZGlyZWN0b3J5
Cit3aGVuIHJ1bm5pbmcgYW4gdW5pbnN0YWxsZWQgYnVpbGQuCiAKIC4uIGxpc3QtdGFibGU6Ogog
ICAgOmhlYWRlci1yb3dzOiAxCkBAIC00NSwxNiArMzYsMjIgQEAgVGhlc2UgbWFjaGluZXMgY2Fu
IGJlIHN0YXJ0ZWQgdGhyb3VnaCB0aGUgSDIgaHlwZXJ2aXNvciBpbWFnZXMgc2hpcHBlZCBpbgog
ICAgICAtIGBgMHhhMDAwMDAwMGBgCiAgICAgIC0gYGBzYTg3OTdwX25zcDBgYAogCitgYGhleGFn
b25fbG9hZGxpbnV4XzxzdWZmaXg+YGAKKyAgQm9vdHMgYSBndWVzdCBvcGVyYXRpbmcgc3lzdGVt
IHdyaXR0ZW4gZm9yIHRoZSBIZXhhZ29uIFZNIGludGVyZmFjZS4KKyAgRGVzcGl0ZSB0aGUgbmFt
ZSwgaXQgaXMgbm90IHNwZWNpZmljIHRvIExpbnV4LiBIMiBzdGFydHMgdGhlIGd1ZXN0IGZyb20K
KyAgYW4gaW1hZ2UgdGhhdCBRRU1VIGhhcyBwbGFjZWQgYXQgdGhlIGBgLWtlcm5lbGBgIGFkZHJl
c3MgaW4gdGhlIHRhYmxlCisgIGFib3ZlLgorCiBgYGhleGFnb25fYm9vdGVyXzxzdWZmaXg+YGAK
LSAgSDIgcGx1cyBhIGxvYWRlciB0aGF0IHJlYWRzIGd1ZXN0IEVMRiBmaWxlcyBmcm9tIHRoZSBo
b3N0IHRocm91Z2ggUUVNVQotICBzZW1paG9zdGluZzo6CisgIFJ1bnMgSDIgdXNlciBwcm9ncmFt
cy4gIFRoZSBib290ZXIgY3JlYXRlcyBhIFZNLCBsb2FkcyBhIHByb2dyYW0KKyAgdGhhdCBpdCBy
ZWFkcyBmcm9tIHRoZSBob3N0IHRocm91Z2ggc2VtaWhvc3RpbmcsIGFuZCB3YWl0cyBmb3IgdGhl
CisgIHByb2dyYW0gdG8gZXhpdDo6CiAKICAgICBxZW11LXN5c3RlbS1oZXhhZ29uIC1NIHFjczY0
OTAtY2RzcCAtc2VyaWFsIHN0ZGlvIC1kaXNwbGF5IG5vbmUgXAogICAgICAgICAtYmlvcyBoZXhh
Z29uX2Jvb3Rlcl9xY3M2NDkwX2Nkc3AgXAotICAgICAgICAtc2VtaWhvc3RpbmctY29uZmlnIGVu
YWJsZT1vbix0YXJnZXQ9bmF0aXZlLGFyZz1ib290ZXIsYXJnPWd1ZXN0LmVsZgorICAgICAgICAt
c2VtaWhvc3RpbmctY29uZmlnIGVuYWJsZT1vbix0YXJnZXQ9bmF0aXZlLGFyZz1ib290ZXIsYXJn
PXByb2cuZWxmCiAKLSAgR3Vlc3RzIGFyZSBsb2FkZWQgYXQgYGAweGEyMDAwMDAwYGAuCisgIFBy
b2dyYW1zIGFyZSBsb2FkZWQgYXQgYGAweGEyMDAwMDAwYGAgYnkgZGVmYXVsdDsgdGhlIGJvb3Rl
cidzCisgIGBgLS1ndWVzdF9iYXNlYGAgb3B0aW9uIGNoYW5nZXMgdGhpcyAoYGBhcmc9LS1oZWxw
YGAgbGlzdHMgaXRzIG9wdGlvbnMpLgogCi1gYGhleGFnb25fbG9hZGxpbnV4XzxzdWZmaXg+YGAK
LSAgSDIgcGx1cyBhIGxvYWRlciB0aGF0IHN0YXJ0cyBhIGtlcm5lbCB3aGljaCBRRU1VIGhhcyBw
bGFjZWQgYXQgdGhlCi0gIGBgLWtlcm5lbGBgIGFkZHJlc3MgaW4gdGhlIHRhYmxlIGFib3ZlLgor
ICBGb3IgbW9yZSBpbmZvLCBzZWUgPGh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9oZXhhZ29u
LWh5cGVydmlzb3I+LgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5y
c3QgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL21hY2hpbmVzLnJzdApuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMC4uYTQ3NjBiN2E1YjEKLS0tIC9kZXYvbnVsbAorKysgYi9kb2Nz
L3N5c3RlbS9oZXhhZ29uL21hY2hpbmVzLnJzdApAQCAtMCwwICsxLDM4IEBACisuLiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitIZXhhZ29uIG1hY2hpbmVzCis9
PT09PT09PT09PT09PT09CisKK0Nob29zZSBhIG1hY2hpbmUgdGhhdCBtYXRjaGVzIHRoZSBydW50
aW1lIGVudmlyb25tZW50IGZvciB0aGUgcHJvZ3JhbSBhbmQKK3RoZSBIZXhhZ29uIElTQSBpdCB0
YXJnZXRzLiBIZXhhZ29uIG1hY2hpbmVzIGZhbGwgaW50byB0d28gYnJvYWQgY2F0ZWdvcmllczoK
K3NpbXVsYXRvci1jb21wYXRpYmxlIG1hY2hpbmVzIGFuZCBib2FyZC1zcGVjaWZpYyBEU1Agc3Vi
c3lzdGVtIG1hY2hpbmVzLgorCitTaW11bGF0b3ItY29tcGF0aWJsZSBtYWNoaW5lcworLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KKworU2ltdWxhdG9yLWNvbXBhdGlibGUgbWFjaGluZXMg
c3VwcG9ydCBzdGFuZGFsb25lIFNESyBPUyBhbmQgUXVSVCBwcm9ncmFtcworaW50ZW5kZWQgZm9y
IHRoZSBIZXhhZ29uIHNpbXVsYXRvciBlbnZpcm9ubWVudC4gVGhleSBwcm92aWRlIHRoZSBjb21t
b24KK0hleGFnb24gc3lzdGVtIGZhY2lsaXRpZXMgZXhwZWN0ZWQgYnkgdGhvc2UgcHJvZ3JhbXMs
IGluY2x1ZGluZyBpbnRlcnJ1cHQKK2FuZCB0aW1lciBzZXJ2aWNlcywgbG9jYWwgbWVtb3J5LCBz
ZW1paG9zdGluZywgYW5kIGEgY29uZmlndXJhdGlvbiB0YWJsZQordGhhdCBkZXNjcmliZXMgdGhl
IHNlbGVjdGVkIG1vZGVsJ3MgY2FwYWJpbGl0aWVzLgorCitTZWxlY3QgdGhlIG1vZGVsIHRoYXQg
bWF0Y2hlcyB0aGUgcHJvZ3JhbSdzIHRhcmdldCBJU0EgYW5kIHRocmVhZGluZworcmVxdWlyZW1l
bnRzLiBgYFY2NkdfMTAyNGBgIGlzIHRoZSBkZWZhdWx0IHdoZW4gYGAtTWBgIGlzIG9taXR0ZWQ7
IGBgc2ltYGAKK3NlbGVjdHMgdGhlIG1vc3QgbW9kZXJuIHNpbXVsYXRvci1zdHlsZSBtYWNoaW5l
LgorCitUaGUgdmlydHVhbCBtYWNoaW5lIChgYHZpcnRgYCkKKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQorCitgYHZpcnRgYCBpcyBhIHN5bnRoZXRpYyBzaW11bGF0b3ItY29tcGF0aWJs
ZSBib2FyZCBmb3Igb3BlcmF0aW5nIHN5c3RlbXMgYW5kCitiYXJlLW1ldGFsIHByb2dyYW1zLiBR
RU1VIHN1cHBsaWVzIGEgZGV2aWNlIHRyZWUgdGhhdCBkZXNjcmliZXMgdGhlIHZpcnR1YWwKK2hh
cmR3YXJlIGF2YWlsYWJsZSB0byB0aGUgZ3Vlc3QsIGluY2x1ZGluZyBDUFVzLCBpbnRlcnJ1cHQg
Y29udHJvbGxlciwKK2NvbnNvbGUsIHZpcnRpbyBkZXZpY2VzLCBhbmQgYWNjZWxlcmF0b3IgY2Fw
YWJpbGl0aWVzLiBTZWUgOmRvYzpgYm9vdGAgZm9yCitpdHMgYm9vdCBwcm90b2NvbC4KKworQm9h
cmQtc3BlY2lmaWMgQ0RTUCBhbmQgTlNQIG1hY2hpbmVzCistLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KKworQm9hcmQtc3BlY2lmaWMgQ0RTUCBhbmQgTlNQIG1hY2hpbmVzIG1v
ZGVsIHRoZSBEU1Agc3Vic3lzdGVtIG9mIGEgbmFtZWQKK1NvQy4KKworRmlybXdhcmUgY2hvaWNl
cyBhcmUgbGlzdGVkIGluIDpkb2M6YGNkc3BgLgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vdGFy
Z2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CmluZGV4IDVk
NDhjZjQwMWFkLi41YTY0NmZkMGQwNCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdApAQCAtMjEsOCAr
MjEsOCBAQCByZXNldCBhbmQgdGhlIGZpcnN0IGluc3RydWN0aW9ucyBhcmUgZmV0Y2hlZCBmcm9t
IEREUiB2aWEgdGhlIEVWQi9yZXNldCB2ZWN0b3IuCiBJbiBhIHJlYWwgc3lzdGVtLCBhIFRCVS9T
TU1VIHdvdWxkIG5vcm1hbGx5IGFyYml0cmF0ZSBBWEkgYWNjZXNzZXMgYnV0CiB3ZSBkb24ndCBo
YXZlIGEgbmVlZCB0byBtb2RlbCB0aGF0IGZvciBRRU1VLgogCi1IZXhhZ29uIERTUCBjb3JlcyB1
c2Ugc2ltdWx0YW5lb3VzIG11bHRpdGhyZWFkaW5nIChTTVQpIHdpdGggYXMgbWFueSBhcyA4Ci1o
YXJkd2FyZSB0aHJlYWRzLgorSGV4YWdvbiBEU1AgY29yZXMgdXNlIHNpbXVsdGFuZW91cyBtdWx0
aXRocmVhZGluZyAoU01UKS4gVGhlIG51bWJlciBvZgoraGFyZHdhcmUgdGhyZWFkcyBkZXBlbmRz
IG9uIHRoZSBtYWNoaW5lLgogCiAuLiBhZG1vbml0aW9uOjogRGlhZ3JhbQogCkBAIC0xMDAsNiAr
MTAwLDcgQEAgbWFjaGluZXMuIFRoaXMgY2FuIGJlIGZ1cnRoZXIgY29uZmlndXJlZCB0aHJvdWdo
IGBgLXNlbWlob3N0aW5nLWNvbmZpZ2BgLgogSGV4YWdvbiBGZWF0dXJlcwogPT09PT09PT09PT09
PT09PQogLi4gdG9jdHJlZTo6CisgICBoZXhhZ29uL21hY2hpbmVzCiAgICBoZXhhZ29uL2VtdWxh
dGlvbgogICAgaGV4YWdvbi9jZHNwCiAKLS0gCjIuMzQuMQoK

