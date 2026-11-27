Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB8606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZJqBcXuq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aEmwFfL3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX2cH-0002t1-8R; Fri, 27 Nov 2026 15:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cC-0002r3-Ub
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cA-0001V2-TA
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:16 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAvNJ1127678
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 df9cfNlMnw9ZDxfjVVxBY5p2J1NYnj6lKTgD1lzptuI=; b=ZJqBcXuq9XOgNBnh
 tWN3gQ2aSi9v93+6MRHRr2MD255D5f021Mb/o6DwF8X0h4Qjdlr1AUHAazmvNlU1
 PM+leSeOEMUrdJy2EoZALbIDf/4anda002SgPFSyxJw4efajIUOGi18OeslPHE5A
 aLx3MN+xFrOLeKhbz7weHFWlKUhg/tVjD0EuRCm4Vjfx5GJHmWocTykX7mJ8NTgb
 /0GUsxCDS3QTgxzkAVxhfsUeoUdCZOycop/Rac00CbBJzQtqGTr7ZoOjaIHPWLlv
 IuINOtZglovLpP9f5WSF3oMtCRSKleIES3TZemytVr0UPCPNEBtRT06oxAG7u9T2
 uh4wTg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6tv9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so5934770c88.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811532; x=1796416332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=df9cfNlMnw9ZDxfjVVxBY5p2J1NYnj6lKTgD1lzptuI=;
 b=aEmwFfL30t+IoGl3va0pKA3QIfc6R2qNU5DDmrDusx48cHMDS8lbttoSAGM6gGWkS6
 9AdpqxTHQgvhjE8TNJ9E4NCfbgp50HJOogLDsw1GORA+nsA/3kaeTcrb6vca+tTI4f01
 dHjt8QIu2Ua9GGRJG6t3ghuVygugbPOYe7YQyHLoSHtJW7kWD3o15WA4gHQuJy04+Y9Q
 6Ux/arpXjpzTwQffwpPRmyF+LEhJDf+Vha3zHPz0k4m8XtUPkfHQ9BYtkI/126Z/7NCu
 v0QP0U/x2Mg9bukWFNck7S26CLTzp0pSw9XilFGE1dSXtuPlpuSbrv1ucbVByaLcu753
 4giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811532; x=1796416332;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=df9cfNlMnw9ZDxfjVVxBY5p2J1NYnj6lKTgD1lzptuI=;
 b=rZXyy4X+vvZfXmDf9p+U2W58UAYlbt3K7W/anPJ+Y04fXG133AOuV2ajXbC036g7GP
 VVSjCBUUhNEVBJ1LZuoUezJ4Y0Gi/og6RUDQ2tPvIvN5HIyOmU6bBg9Eo072exF3WfzW
 GGsQCPSOoyvV4SCf9dNsdnzDZPV6l418lpFKxBL5YlWdhUxcwS7rE6OJcPQFrissv7vZ
 1BeFvFO6kcvVRQuXvmIFs6winHVt8aFEmJiFqlIRRU6IK8a1i89JmmNDvXjCjyu8GRuu
 L3i+0cxtwDWKj++Q8jHgWOvombF7r4+6H3XqvXAP9xKnduUBkCL9os9kUnHPETvFftmB
 L/9g==
X-Gm-Message-State: APuU4Z9yMPx4vKXggocaJk6ojPQMTKbi8yum+QbkHer7wGcljApXZb5s
 KfwCWTUnHeRCa2a+XbeviNQjygBoEumsYsISyQy8dsguwwT+XWpQRaJg0jxZuRkjajeLDEZLaqa
 ftmFwTL4v3X+mXjMDqq2DmItz1kx9ohEJaoiNSVaN03DUlnaGciKvq5rYCMVH4mNqVg==
X-Gm-Gg: AZFdTZdGfnQUAc72oLeIq18pyV/ymuBl9WXwY/X9is9d26gg6H6TXekd0GRVZaSHeAA
 TJFmzifM36CUDvNVVUbJzKEJ9n52GJ62dz1EL7UOSngF5plbT9dgN7Ubb9D5IANSkd26XyVAs0X
 gNg0zcYx/grJISvOgedojAaBj97qzSBDkqUPhCKf2xsA2+HttMgMHtvtoAQtNfgyXXf4bkrLsvV
 FdwNBrePiemqPww33akeV/WFnONOHCiZ3Vi4OWItujmp1IMJMtv8dhTevkjz8DXS2UBlpPoMof1
 9a/bCSRFaMpHTPzXjYkjbsCYBGaErupBBvabkkv0IMMbTriKW3/+eU58LD0w95OKExzdpgQHJQv
 QqS5yeHauz9q+/jx9Pd6q78i0/jVmE1t2h+4amOHNg2j/E2oMNcTXDIOrHr+euk7KiEBanE45jE
 1opaiC3jDq4OyRK4WDYdRP
X-Received: by 2002:a05:7022:5f08:b0:1b5:23eb:530b with SMTP id
 a92af1059eb24-1b5568de6e7mr28274549c88.23.1795811532201; 
 Fri, 27 Nov 2026 12:32:12 -0800 (PST)
X-Received: by 2002:a05:7022:5f08:b0:1b5:23eb:530b with SMTP id
 a92af1059eb24-1b5568de6e7mr28274527c88.23.1795811531670; 
 Fri, 27 Nov 2026 12:32:11 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55681301asm59248021c88.8.2026.11.27.12.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:32:11 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH for-12.0 v2 1/5] dump: fix e_ehsize in ELF core headers
Date: Fri, 27 Nov 2026 12:32:05 -0800
Message-Id: <20261127203209.42752-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
References: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Rt1dyzDpSICl93eqmtXtY558fdhT_S3L
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09e8cd cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YYXFeDNx8urxxFB-_bQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX5+OaeWs6Rh46
 WVGnpxpfbfEWwZSeJltKUhJD4s+ZDTw74egOeZuGo99aQ5EO+qNdyzXdArTuQ8nAc/HnLewR9sx
 L4YMUqC1Htwi86jglJLE1+4lL5DU5NY=
X-Proofpoint-GUID: Rt1dyzDpSICl93eqmtXtY558fdhT_S3L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX0fiBTiyyyGwl
 tC4013PDHYwAZnWRPL0Jm660/g5dsbnNqAjZ+ZKFDeemidELadGNXStJ3KNJmzzcwrkdwQhfrx2
 Yn39Pm+qGizvOu/gnCreLnvfbvQ1YI0FQjO6TWpo8oYEyO6Asr3lraCDXTIh9GV8YS0cKCH4y8A
 ffNR4hnIMh48ekCyH186x9nO1vHVmKDM7/CurZ4yD5E+L5ImHekn7WjuSsmyLzSTUkXgs6XoII+
 3GPuSt/jPj0nqP1JJvc5OKCx7yozXltlU0nBJEO1dRBAQki5Eog3M2lmzInSIQYbh1W6N3G8evs
 3VEykkcAQQ7w+MhAcTD5TiTrQbqewxKPyeJZKBJ50W2uMPWyzuLHaDVOaRjg6PBVSGVeENKBWcf
 KrScoCKW+b2yaPmwv0Emmw4/zDSSnjCPW46AkX9rIg6lbDhcOKCLAIRQU+Qcmn1QiwS2tJPGKXF
 hfJ69KLnQbqg9cBDWww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
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

cHJlcGFyZV9lbGZ7MzIsNjR9X2hlYWRlcigpIHVzZWQgdGhlIHdyb25nIHNpemUgZm9yIHRoZSBl
bGZfaGVhZGVyLgoKZV9laHNpemUgZmllbGQgcmVhZHMgOCBvbiBhIHR5cGljYWwgaG9zdCBpbnN0
ZWFkIG9mIDUyLzY0IGZvciBFTEYzMiw2NC4KClVzZSBzaXplb2YoKmVsZl9oZWFkZXIpIGluc3Rl
YWQuCgpGaXhlczogNjcwZTc2OTk4YTZlICgiZHVtcDogU3BsaXQgZWxmIGhlYWRlciBmdW5jdGlv
bnMgaW50byBwcmVwYXJlIGFuZCB3cml0ZSIpClJldmlld2VkLWJ5OiBIZWxnZSBEZWxsZXIgPGRl
bGxlckBnbXguZGU+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiBkdW1wL2R1bXAuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kdW1wL2R1bXAuYyBi
L2R1bXAvZHVtcC5jCmluZGV4IDIzYWM2ODk5MDdhLi42YjU2ODUxNjk2MCAxMDA2NDQKLS0tIGEv
ZHVtcC9kdW1wLmMKKysrIGIvZHVtcC9kdW1wLmMKQEAgLTE1Nyw3ICsxNTcsNyBAQCBzdGF0aWMg
dm9pZCBwcmVwYXJlX2VsZjY0X2hlYWRlcihEdW1wU3RhdGUgKnMsIEVsZjY0X0VoZHIgKmVsZl9o
ZWFkZXIpCiAgICAgZWxmX2hlYWRlci0+ZV90eXBlID0gY3B1X3RvX2R1bXAxNihzLCBFVF9DT1JF
KTsKICAgICBlbGZfaGVhZGVyLT5lX21hY2hpbmUgPSBjcHVfdG9fZHVtcDE2KHMsIHMtPmR1bXBf
aW5mby5kX21hY2hpbmUpOwogICAgIGVsZl9oZWFkZXItPmVfdmVyc2lvbiA9IGNwdV90b19kdW1w
MzIocywgRVZfQ1VSUkVOVCk7Ci0gICAgZWxmX2hlYWRlci0+ZV9laHNpemUgPSBjcHVfdG9fZHVt
cDE2KHMsIHNpemVvZihlbGZfaGVhZGVyKSk7CisgICAgZWxmX2hlYWRlci0+ZV9laHNpemUgPSBj
cHVfdG9fZHVtcDE2KHMsIHNpemVvZigqZWxmX2hlYWRlcikpOwogICAgIGVsZl9oZWFkZXItPmVf
cGhvZmYgPSBjcHVfdG9fZHVtcDY0KHMsIHMtPnBoZHJfb2Zmc2V0KTsKICAgICBlbGZfaGVhZGVy
LT5lX3BoZW50c2l6ZSA9IGNwdV90b19kdW1wMTYocywgc2l6ZW9mKEVsZjY0X1BoZHIpKTsKICAg
ICBlbGZfaGVhZGVyLT5lX3BobnVtID0gY3B1X3RvX2R1bXAxNihzLCBwaG51bSk7CkBAIC0xODQs
NyArMTg0LDcgQEAgc3RhdGljIHZvaWQgcHJlcGFyZV9lbGYzMl9oZWFkZXIoRHVtcFN0YXRlICpz
LCBFbGYzMl9FaGRyICplbGZfaGVhZGVyKQogICAgIGVsZl9oZWFkZXItPmVfdHlwZSA9IGNwdV90
b19kdW1wMTYocywgRVRfQ09SRSk7CiAgICAgZWxmX2hlYWRlci0+ZV9tYWNoaW5lID0gY3B1X3Rv
X2R1bXAxNihzLCBzLT5kdW1wX2luZm8uZF9tYWNoaW5lKTsKICAgICBlbGZfaGVhZGVyLT5lX3Zl
cnNpb24gPSBjcHVfdG9fZHVtcDMyKHMsIEVWX0NVUlJFTlQpOwotICAgIGVsZl9oZWFkZXItPmVf
ZWhzaXplID0gY3B1X3RvX2R1bXAxNihzLCBzaXplb2YoZWxmX2hlYWRlcikpOworICAgIGVsZl9o
ZWFkZXItPmVfZWhzaXplID0gY3B1X3RvX2R1bXAxNihzLCBzaXplb2YoKmVsZl9oZWFkZXIpKTsK
ICAgICBlbGZfaGVhZGVyLT5lX3Bob2ZmID0gY3B1X3RvX2R1bXAzMihzLCBzLT5waGRyX29mZnNl
dCk7CiAgICAgZWxmX2hlYWRlci0+ZV9waGVudHNpemUgPSBjcHVfdG9fZHVtcDE2KHMsIHNpemVv
ZihFbGYzMl9QaGRyKSk7CiAgICAgZWxmX2hlYWRlci0+ZV9waG51bSA9IGNwdV90b19kdW1wMTYo
cywgcGhudW0pOwotLSAKMi4zNC4xCgo=

