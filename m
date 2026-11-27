Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JSToEpEE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bIWkKy2R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX2cH-0002tE-SM; Fri, 27 Nov 2026 15:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cD-0002rV-Rn
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cB-0001jj-Mk
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:17 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJBXGd2762926
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dycv0ffpOVX428w+MQqS97N3G7y1RWLQeTKAoLT43zs=; b=JSToEpEEB+Pi5+Jc
 jAGyJywXtRfhhsWgNLt5rbxHtTt995Gc0qkKcD902aJNNm8/5KWKbF6qLzilDrx/
 vmFA+IJGERwJmH/pmkTlmX0xWznruv/Bf8peHcH9oh6sNtfhQ+4BWK4lBs1nyeIx
 PLEhhlVFi0c77yFQ1dHGCOr0M1tZ/ZyyhlwN9OaiLVmXfF6hteEokK85wLgRJkUw
 vdVeGhVXGgPbeEWG4C6+mO3p0jMhNVqnVupFbzrOyTxIw9+Ruk8wNz7LrXlvV7In
 TFihPvlbnXMPgOM/47UKH8eMAxnZxel0msIWRDOx0KiPGfpRgkHqwG3nLyqS0mZw
 IiHKPw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756kaqjf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-386df943355so1421676eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811534; x=1796416334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dycv0ffpOVX428w+MQqS97N3G7y1RWLQeTKAoLT43zs=;
 b=bIWkKy2RKeXOgmQDljSs0zfVa569EWVgePu7qbzsF5Ov2fF+ybiyWHsbkmd+CvW+Im
 tsYX+eWVl58F6YH8Lv0bVfhXi0TJMJwlNZWTozDdzV4Ie4nYER3drNycgb3y0C0TYbjz
 KMLEhW0bBIOhjBUFGzji1Tww9WIyrliIqHfu0DsPT99tq2LKfuymU/qZrPLE0QFYyoNh
 OMoQzI4b0CzW4FX3mOpuDWpdj+a91RY6E7bfxnU65AA7RIOCaAY6d3PKBPksIzS8QWNL
 2+ZHL7u5Br7fnmMkTeDwLgHfRCvmSuFzY1dvDf5OU14gyY84PtrWxZvZ8ZgArsF7gp9A
 ojtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811534; x=1796416334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dycv0ffpOVX428w+MQqS97N3G7y1RWLQeTKAoLT43zs=;
 b=nPMOgmZ61g1ClDayasHY5pOditEmSHpXpgbPTCy6ITmLqlfvIANMBP+NyhA+9tNiQq
 py1nPFFdgTqmcVaWjTFXz3ma5KiMuaVTQyBZTsRcX2qWQUp5kKsnpCU/d4scc+vog0AZ
 vebWHXRtp/n1bTCCGYnwdaqtaOYESDJVgoda4fE8XPvuSDS58m3S0Nkg2SxBSdMa2jbR
 8dwPRqzip3gqlq+WiMZnigyhLFfdeMjc+zpOL3ghXYd6qmIMi6bCI7Hm4LFbDjHhD/It
 ADB0qZXwT1aqP+jh6G01Frq/Vhyfs5VgqPXgLGR++BoipMxdzKp1qklLYUXGUz5JbVrx
 bXiA==
X-Gm-Message-State: APuU4Z9PoWQrFZ6fIimZWhU9OI6CxpwVHgF57jAOoE05k3p3rwUX7xBP
 KETWncUoxtcd1w8NQwh+CPNmW+hdX5YxqvG6dJepXG41cbzax3xeG29VBHpXXBZZuonphAkDL+u
 2/jBuy+AO7p5MKv3R3lH66qjj5Fnzx3sdQ/ncNHYEa+57I4r7oP54IKK8YRVrXs6hUg==
X-Gm-Gg: AZFdTZd+Xym2kjl7V3Ctq5SiQrnrzYtH6keqS+Zy0bLgQPnnFfieVXT3yoEwFV0Jqh/
 ev+VuM9Z1NOD6k3kay5cnVJS9VzUt3jP2v2GHkrMooKGmtyemq8d0MqM8Iitg3SUQWk5XOeA1vz
 +6cq/pXpzU7csebPTv1Lh7aD4xnODTLIVk0amg1e/q5np/aq4CyTPMjW+8Ip0RGQhT6Q5JA45wL
 a1GnkaIO03AFqe513xZmOMZgz2fSJbvZt7ir87iFKcqEdceAyzorQixWRtnO9Kswkno2SQW/+3t
 ueYhloL3PDJ2+77KDI7W75lkZgPExhjUqzwaa3W7jEPXfV/34IV51TNrljPjO6sGutVjkH8J9nR
 ehiM6WzQD4vEbEr4hxkFoRH/ytq2rq29puz/nJue/Cr3pWzenxlv5Zxd2b91M8hvSWI4z67Mol7
 wPIRLQKIkxee1VQzQ4qbwr
X-Received: by 2002:a05:7022:7f19:b0:19f:cc98:f603 with SMTP id
 a92af1059eb24-1b5520d7d86mr23999572c88.1.1795811533606; 
 Fri, 27 Nov 2026 12:32:13 -0800 (PST)
X-Received: by 2002:a05:7022:7f19:b0:19f:cc98:f603 with SMTP id
 a92af1059eb24-1b5520d7d86mr23999546c88.1.1795811533088; 
 Fri, 27 Nov 2026 12:32:13 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55681301asm59248021c88.8.2026.11.27.12.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:32:12 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH for-12.0 v2 2/5] dump: let targets set e_flags in the ELF core
 header
Date: Fri, 27 Nov 2026 12:32:06 -0800
Message-Id: <20261127203209.42752-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
References: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX6ksR/KK8dOqB
 OWoz7rGZzfoSIDxAwu24KYsrTZSoqj1Czw1BHROjOl2+L+BgS6QlE60cnR00DxoOHrV01CY8D9k
 ZpqixPO1qSxDDun6ddf6pJm3YOx43NLtB/NeZ9cduhd9gBOnfS0VGc1Gg3s4D3mOfQTvh7sKBt0
 7/RnYbN9gHOOZ3o/kaVr0ggCjSxaHqfsBZJUnYJvbdaP5VhL8Cs7tTyeqgKLMDnUVX8iW02vEB+
 JHt73A6AP3pHSs/bFwEGnUIbGy4mXO8ZV4JBhS+m9GIF/1MLuNTDGpvanT/WcD1uRPao+O6DL/S
 Hz7b4nhE9jOS0Fim/GGy/P1UyzFvwo2+dE+LBHvTIqFjcsCU6GoCKrFLUebS6VBi6jwmZUTxE+O
 /UmViBtfwsDKrw1vO6ULueGh+TfoI0iSdaeauTSBRfC1ZmG8Y3TjHy4LsbPy69RSj757+cznuYL
 T8Rm+bcQxJZzOfUnqRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfXzyIYFf3znKWv
 HE6XkBEjtXzDLctZvUFzHP5xTCNwwqnRhatRMewVRsl4AdO+nq7VbghLnc5Ju9RUZdVimc/xPsO
 E0OrN+9jhIuGWIdOyzIC5leZYB7MwG0=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b09e8ce cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=d927mnl5WceuBYyLXBcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 8Lepg9jDMavV7RupBEmaGK8nBOiWcorT
X-Proofpoint-ORIG-GUID: 8Lepg9jDMavV7RupBEmaGK8nBOiWcorT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
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

U29tZSB0YXJnZXRzIGVuY29kZSBtYWNoaW5lIGRldGFpbHMgaW4gdGhlIEVMRiBoZWFkZXIgZV9m
bGFncyBmaWVsZCwKaGV4YWdvbiBmb3IgZXhhbXBsZSBpbmNsdWRzIHRoZSBJU0EgdmVyc2lvbi4K
CkFkZCBhIGRfZmxhZ3MgbWVtYmVyIHRvIEFyY2hEdW1wSW5mbyBhbmQgZW1pdCBpdCBpbiB0aGUg
RUxGezMyLDY0fSBoZWFkZXJzLgoKUmV2aWV3ZWQtYnk6IEhlbGdlIERlbGxlciA8ZGVsbGVyQGdt
eC5kZT4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3Nz
LnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvc3lzdGVtL2R1bXAtYXJjaC5oIHwgMSArCiBkdW1w
L2R1bXAuYyAgICAgICAgICAgICAgICB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0ZW0vZHVtcC1hcmNoLmggYi9pbmNsdWRl
L3N5c3RlbS9kdW1wLWFyY2guaAppbmRleCA4NmI5YWUxNWI2YS4uZjQyZTBlNDhjZjUgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvc3lzdGVtL2R1bXAtYXJjaC5oCisrKyBiL2luY2x1ZGUvc3lzdGVtL2R1
bXAtYXJjaC5oCkBAIC0xOCw2ICsxOCw3IEBAIHN0cnVjdCBBcmNoRHVtcEluZm8gewogICAgIGlu
dCBkX21hY2hpbmU7ICAgICAgICAgICAvKiBBcmNoaXRlY3R1cmUgKi8KICAgICBpbnQgZF9lbmRp
YW47ICAgICAgICAgICAgLyogRUxGREFUQTJMU0Igb3IgRUxGREFUQTJNU0IgKi8KICAgICBpbnQg
ZF9jbGFzczsgICAgICAgICAgICAgLyogRUxGQ0xBU1MzMiBvciBFTEZDTEFTUzY0ICovCisgICAg
dWludDMyX3QgZF9mbGFnczsgICAgICAgIC8qIE1hY2hpbmUtc3BlY2lmaWMgZV9mbGFncyBvZiB0
aGUgRUxGIGhlYWRlciAqLwogICAgIHVpbnQzMl90IHBhZ2Vfc2l6ZTsgICAgICAvKiBUaGUgdGFy
Z2V0J3MgcGFnZSBzaXplLiBJZiBpdCdzIHZhcmlhYmxlIGFuZAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKiB1bmtub3duLCB0aGVuIHRoaXMgc2hvdWxkIGJlIHRoZSBtYXhpbXVtLiAq
LwogICAgIHVpbnQ2NF90IHBoeXNfYmFzZTsgICAgICAvKiBUaGUgdGFyZ2V0J3MgcGh5c21lbSBi
YXNlLiAqLwpkaWZmIC0tZ2l0IGEvZHVtcC9kdW1wLmMgYi9kdW1wL2R1bXAuYwppbmRleCA2YjU2
ODUxNjk2MC4uZGIyOTgzYzI0NjMgMTAwNjQ0Ci0tLSBhL2R1bXAvZHVtcC5jCisrKyBiL2R1bXAv
ZHVtcC5jCkBAIC0xNTcsNiArMTU3LDcgQEAgc3RhdGljIHZvaWQgcHJlcGFyZV9lbGY2NF9oZWFk
ZXIoRHVtcFN0YXRlICpzLCBFbGY2NF9FaGRyICplbGZfaGVhZGVyKQogICAgIGVsZl9oZWFkZXIt
PmVfdHlwZSA9IGNwdV90b19kdW1wMTYocywgRVRfQ09SRSk7CiAgICAgZWxmX2hlYWRlci0+ZV9t
YWNoaW5lID0gY3B1X3RvX2R1bXAxNihzLCBzLT5kdW1wX2luZm8uZF9tYWNoaW5lKTsKICAgICBl
bGZfaGVhZGVyLT5lX3ZlcnNpb24gPSBjcHVfdG9fZHVtcDMyKHMsIEVWX0NVUlJFTlQpOworICAg
IGVsZl9oZWFkZXItPmVfZmxhZ3MgPSBjcHVfdG9fZHVtcDMyKHMsIHMtPmR1bXBfaW5mby5kX2Zs
YWdzKTsKICAgICBlbGZfaGVhZGVyLT5lX2Voc2l6ZSA9IGNwdV90b19kdW1wMTYocywgc2l6ZW9m
KCplbGZfaGVhZGVyKSk7CiAgICAgZWxmX2hlYWRlci0+ZV9waG9mZiA9IGNwdV90b19kdW1wNjQo
cywgcy0+cGhkcl9vZmZzZXQpOwogICAgIGVsZl9oZWFkZXItPmVfcGhlbnRzaXplID0gY3B1X3Rv
X2R1bXAxNihzLCBzaXplb2YoRWxmNjRfUGhkcikpOwpAQCAtMTg0LDYgKzE4NSw3IEBAIHN0YXRp
YyB2b2lkIHByZXBhcmVfZWxmMzJfaGVhZGVyKER1bXBTdGF0ZSAqcywgRWxmMzJfRWhkciAqZWxm
X2hlYWRlcikKICAgICBlbGZfaGVhZGVyLT5lX3R5cGUgPSBjcHVfdG9fZHVtcDE2KHMsIEVUX0NP
UkUpOwogICAgIGVsZl9oZWFkZXItPmVfbWFjaGluZSA9IGNwdV90b19kdW1wMTYocywgcy0+ZHVt
cF9pbmZvLmRfbWFjaGluZSk7CiAgICAgZWxmX2hlYWRlci0+ZV92ZXJzaW9uID0gY3B1X3RvX2R1
bXAzMihzLCBFVl9DVVJSRU5UKTsKKyAgICBlbGZfaGVhZGVyLT5lX2ZsYWdzID0gY3B1X3RvX2R1
bXAzMihzLCBzLT5kdW1wX2luZm8uZF9mbGFncyk7CiAgICAgZWxmX2hlYWRlci0+ZV9laHNpemUg
PSBjcHVfdG9fZHVtcDE2KHMsIHNpemVvZigqZWxmX2hlYWRlcikpOwogICAgIGVsZl9oZWFkZXIt
PmVfcGhvZmYgPSBjcHVfdG9fZHVtcDMyKHMsIHMtPnBoZHJfb2Zmc2V0KTsKICAgICBlbGZfaGVh
ZGVyLT5lX3BoZW50c2l6ZSA9IGNwdV90b19kdW1wMTYocywgc2l6ZW9mKEVsZjMyX1BoZHIpKTsK
LS0gCjIuMzQuMQoK

