Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F2606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dDCTwwdl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c0orz4P5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoqH-0007iC-DF; Sat, 24 Oct 2026 23:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqF-0007hg-Tc
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqE-0001TP-5D
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P182uw4176471
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=; b=dDCTwwdlzSJ+n5u3
 uBxJNC5azYt6Ch7gPFzmRimIfjmON+z6S9FpU2KRB9cAhXfcg0wq/DNDIpdIaJH/
 pWON7ZxexXBGrf6TJAWIAV7RFqHdhrcCqsWPwlwDFpjWVcVm3SinSn2b0LW1dxRL
 zbwlu6QAYrh+4wTnzk6OyhsjEydS4W8+gHDDcDARKNRsB7yJCSN0GtU3tLK2W+FS
 Ei5qahRfN7K7ECFaSk0xdDuVLVPIOgNisFXt0spMvPSmpN3fDCtRvivOU1ZB3I/Z
 Vbva5Js+fO0fk5SXEXh9fA/tMYBpz3Ru+0bNDsNxbP1TUf7WHAFuKILRFPB56OZT
 vrooAw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgtna3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4124388eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898651; x=1793503451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=c0orz4P5QpUDFvALePHn2N5xaR8xsjrrOLfrIL3iOnHN5TX2JWvh6RdsGSzqOrmPMs
 MGO5SMekeLzJx/WCiHhTLzpVtDUwrWOogxhgSfCzojGVOZHGUWaNWXT8QAvmBbrfl0nL
 ENbew4U5ZnM4jMy8QUMZX+fwp/Zm3/dJU2MY+ViDOTGfEP4+vMhssuU98FP2MImutG5A
 djXPlBWxXBYJclNsMg34eEtrCiau83nZKIGyPW/SAmzaBpybRWW4OCLObl4yySg0bTFd
 mX61iZ+8EeLAs2nEzne8EtKde9PFKQEq6HjCIF6p2ndxT/CteWOBLAbmzpWB0dvfGZTv
 Oe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898651; x=1793503451;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=c0Paf1Blx5U+sU80S+8sbpL3N9zRIovlGiQKCCRgYBX6EGXYXJiMbgHH8nrX8ckR/0
 s4GUVJjuqjM9zDnPzmqC1FC8f6bcbDqZ99UlQSu4g4nTOr3/81CFc3YLubRpZDSRwtdN
 Bnxy9tPMUS8TG3q+F0VM5QeqQCDbQLBYpNpKLZu8+8uGxe5J6jcCP8dCZVzSkS+uoMSX
 s5pvTpfOJXHVNHyuODCuuidCBVpp6FIQ/+9iEvfg05WXEXdYNRApGLmz2K4QB7JKnkXX
 0Qg1wV+NCRAkh5qm8g7e6RAYDbfbTILJlOVX9BIFVjVDDk7yQcZvIPAPMXeKlrybY6B/
 RV4w==
X-Gm-Message-State: AFq9FYKhl7bv9EC8EJgMVCAvTs14WYDeK6fqt3hcbtpWwFdkyPNtzy6i
 Sz8acreNfTjdlAD77wZM/T11g05IEs/k2/bH0IDFUBcnxwq/bYs3KuWgpQu1HlPvYobqO05oT6a
 ovtPejR0aeugu56U9Kuvx5yPvH3WdY9+5/LKsolZg9vesmVzVD1W8CXBlYIVc57TKxA==
X-Gm-Gg: AYBFou1RlgQAUmXMxiD/PqtxhyuEXYyaONqcp5ucW2te+pMSldRyndU2xgaUt1V+Lzl
 S+OW1XMifAM0fKxw6n37p4kOJhzlESyztQwElXDyHtnYn6CAqYwRcXoxrNfxxETYNoItGcRYNRy
 QIIBw0mCld2lHTrmFi3KDHkQRbZ6YM1a75Gs2w/1HhjMjVMzapSaiRqoZQ5x2y9cJ5HEsqRuDdm
 hiDwdaNsSpbH67bBa4tlwCDiMobMkKQ0EdJpKDzP0Jlc/cu2rIAKzftE+c6smWGOEfXoGSv0MlS
 Z94Qo4Zw+TsPnjgH+mFHQsStHoDRvJNth2VJtId/y0s4OqcRMFlt3w9pJAIyfzYVf5/mwv3SsLN
 gVbE5I3exwdifRTbxF5c3kz2Zr5I5x5dN1hHFHjbub6cmKjY=
X-Received: by 2002:a05:7023:885:b0:149:d501:b990 with SMTP id
 a92af1059eb24-1993677a1b1mr6045600c88.25.1792898651289; 
 Sat, 24 Oct 2026 20:24:11 -0700 (PDT)
X-Received: by 2002:a05:7023:885:b0:149:d501:b990 with SMTP id
 a92af1059eb24-1993677a1b1mr6045560c88.25.1792898650762; 
 Sat, 24 Oct 2026 20:24:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL v2 10/40] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
Date: Sat, 24 Oct 2026 20:23:16 -0700
Message-Id: <20261025032346.2917451-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX8uq8BUX8Dqct
 lLR6pOaz4CE0HZdfoPzCdkqueXfKBdbTlOlW3MRptmW1kRTGKNLWynVRZwdoTmYVUFMHAIBoPS5
 YJ8GvToDjUgzA/NWr2lsQefJ3+InCCE=
X-Proofpoint-GUID: BvX2ylKtUfE-PehgyF19lH1VZpmPBXbo
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6add765c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=EkHQ-IOB5RTo-Ixd14sA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfXzCtD7PmVwW0t
 luhq8CQ6XYSzEFxRWSpxfe5l6Ene4G929SEU3dgu1qGjf4XTOah+wAXddIw4UK2IoePAFdLPpuu
 /f/MbkkDoyo8O/AaiZvRu8o08Nzxy+XHx+EXqJ4C80Mpg6nGE5lY5bo8LemtaRN0r+A4M87FSBi
 iHMr5G7BqUYZE/oTePhAVJgSjWdxHaIHlQPAIqv28MQsXRxUI/p1x2SmIAr9kuGUaAfUwSfwlA4
 1dBICdBacrNtchmPSxTNeZo1taFt3HZ0bCqtwVoBrMHkFUc/6AyhaXUknFvsgfb7pBR+gGOq175
 B+Om14d7iVB7ExDplMsPAHPN6tmYEbKhXyIWsywt6BDLwO3OmbkUVLwfjxoibvEDh134gTODqpb
 dKTJRZQqfCuwkJL6y+6cj7toyzlyRcVnPevEQZiF23rsLwpwzOWB49sDbyf+kpUmnRUYKZaY0sC
 zcOIQwjG6XAqGO1fkew==
X-Proofpoint-ORIG-GUID: BvX2ylKtUfE-PehgyF19lH1VZpmPBXbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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

Qml0IDcgb2YgTDRfbG9hZHdfcGh5cyBpcyB2YWxpZCB0aHJvdWdoIHY4MSBidXQgcmVzZXJ2ZWQg
c3RhcnRpbmcKd2l0aCB2ODMuIERlY29kZSBpdCBhcyBhIGxlZ2FjeSBkb24ndC1jYXJlIGJpdCwg
dGhlbiByZWplY3QgaXQgZm9yIHY4MwphbmQgbGF0ZXIuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTog
TWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2RlY29kZS5oICAgIHwgIDIgKysKIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgIHwg
MTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMgfCAgMyAr
Ky0KIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5oIGIvdGFyZ2V0L2hleGFnb24vZGVjb2Rl
LmgKaW5kZXggZDRiMDQ5OTYxZWQuLjFlMWUzMzliMDhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9kZWNvZGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuaApAQCAtMzEsNSArMzEs
NyBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG1heF93b3Jkcywg
Y29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAgICAgICAgICAgUGFja2V0ICpwa3QsIGJv
b2wgZGlzYXNfb25seSk7CiAKIGJvb2wgb3Bjb2RlX3N1cHBvcnRlZCh1aW50MTZfdCBvcGNvZGUs
IGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOworYm9vbCBlbmNvZGluZ19zdXBwb3J0ZWQo
dWludDE2X3Qgb3Bjb2RlLCB1aW50MzJfdCBlbmNvZGluZywKKyAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOwogCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKaW5kZXgg
YTI4YmY5Y2U5ZmUuLjM1ZDc0MWNlODY0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAtNjkyLDYgKzY5MiwyMiBAQCBi
b29sIG9wY29kZV9zdXBwb3J0ZWQodWludDE2X3Qgb3Bjb2RlLCBjb25zdCBIZXhhZ29uQ1BVRGVm
ICpoZXhfZGVmKQogICAgIHJldHVybiB0cnVlOwogfQogCisvKgorICogU29tZSBlbmNvZGluZ3Mg
b2YgYW4gb3RoZXJ3aXNlIHN1cHBvcnRlZCBvcGNvZGUgYXJlIHJlc2VydmVkIG9uIG5ld2VyCisg
KiB2ZXJzaW9ucy4gIEhFWF9WRVJfQU5ZICh1c2VkIHdoZW4gb25seSBkaXNhc3NlbWJsaW5nKSBh
Y2NlcHRzIGV2ZXJ5dGhpbmcuCisgKi8KK2Jvb2wgZW5jb2Rpbmdfc3VwcG9ydGVkKHVpbnQxNl90
IG9wY29kZSwgdWludDMyX3QgZW5jb2RpbmcsCisgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBIZXhhZ29uQ1BVRGVmICpoZXhfZGVmKQoreworICAgIC8qIEJpdCA3IG9mIEw0X2xvYWR3X3Bo
eXMgYmVjYW1lIHJlc2VydmVkIGluIHY4My4gKi8KKyAgICBpZiAoaGV4X2RlZi0+aGV4X3ZlcnNp
b24gIT0gSEVYX1ZFUl9BTlkgJiYKKyAgICAgICAgaGV4X2RlZi0+aGV4X3ZlcnNpb24gPj0gSEVY
X1ZFUl9WODMgJiYKKyAgICAgICAgb3Bjb2RlID09IEw0X2xvYWR3X3BoeXMgJiYgKGVuY29kaW5n
ICYgMHg4MCkpIHsKKyAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKyAgICByZXR1cm4gdHJ1
ZTsKK30KKwogLyoKICAqIGRlY29kZV9wYWNrZXQKICAqIERlY29kZXMgcGFja2V0IHdpdGggZ2l2
ZW4gd29yZHMKQEAgLTcyMiw2ICs3MzgsOSBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IG1heF93b3JkcywgY29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAg
ICAgLyogSW52YWxpZCBpbnN0cnVjdGlvbiBlbmNvZGluZyAqLwogICAgICAgICAgICAgcmV0dXJu
IDA7CiAgICAgICAgIH0KKyAgICAgICAgaWYgKCFlbmNvZGluZ19zdXBwb3J0ZWQoaW5zbi0+b3Bj
b2RlLCBlbmNvZGluZzMyLCBjdHgtPmhleF9kZWYpKSB7CisgICAgICAgICAgICByZXR1cm4gMDsK
KyAgICAgICAgfQogICAgICAgICAvKgogICAgICAgICAgKiBJZiB3ZSBzYXcgYW4gZXh0ZW5kZXIs
IG1hcmsgbmV4dCB3b3JkIGV4dGVuZGVkIHNvIGltbWVkaWF0ZQogICAgICAgICAgKiBkZWNvZGUg
d29ya3MKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jIGIvdGFyZ2V0L2hl
eGFnb24vcHJpbnRpbnNuLmMKaW5kZXggMDIzZWExMmRiYTUuLmNkYjlkY2Q3ZGU5IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9wcmludGluc24uYworKysgYi90YXJnZXQvaGV4YWdvbi9wcmlu
dGluc24uYwpAQCAtMTcxLDcgKzE3MSw4IEBAIHZvaWQgc25wcmludF9hX3BrdF9kaXNhcyhHU3Ry
aW5nICpidWYsIFBhY2tldCAqcGt0LCB1aW50MzJfdCAqd29yZHMsCiAgICAgICAgIH0KIAogICAg
ICAgICBnX3N0cmluZ19hcHBlbmQoYnVmLCAiXHQiKTsKLSAgICAgICAgaWYgKG9wY29kZV9zdXBw
b3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgY2ZnLT5oZXhfZGVmKSkgeworICAgICAgICBpZiAo
b3Bjb2RlX3N1cHBvcnRlZChwa3QtPmluc25baV0ub3Bjb2RlLCBjZmctPmhleF9kZWYpICYmCisg
ICAgICAgICAgICBlbmNvZGluZ19zdXBwb3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgd29yZHNb
aV0sIGNmZy0+aGV4X2RlZikpIHsKICAgICAgICAgICAgIHNucHJpbnRpbnNuKGJ1ZiwgJihwa3Qt
Pmluc25baV0pKTsKICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVu
ZChidWYsICI8aW52YWxpZD4iKTsKLS0gCjIuMzQuMQoK

