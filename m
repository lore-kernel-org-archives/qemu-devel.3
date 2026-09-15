Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FD7C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4C-0005zX-40; Tue, 15 Sep 2026 12:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3m-0005v8-Ms
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3k-0003oH-W1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAphS125473
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TD9oBr1J7/EIT0M0+rkmdoRA3UBnrqOUEqn9r3Ju3k0=; b=JP9xZOH9aKiXl4bg
 I3sQx+M2tw3G+jLaWbNeDxy3pTa0B5j0UIZKqbzJHE+UTesOP8V4sdr1CPum+Y/g
 b6H2xoWW8dVfOnflXCQr5Hj3Hd0DxxKhXTPA1ag8GBzsMcALWqPQs1xLm8+Z4Gsl
 ECXO00i/367wSWrtM1nzvUmc2DfWtDW/LRNS6NjO4YbdBIuBL18hfWyff/c11sMZ
 ukuebh8bciMYe4ZCyvqNLgSi1TJHBb7LAbUkhIFUzCdX7Gsds2n4GX+9YgBEDlJf
 1qGfSmSGs3AwXtKiwo24RL25Za3fHXWGg7jlJW8s2pUmH1A/0Fq8nmKG3PLaocJM
 lBNzdw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtt65d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso3200541a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489863; x=1790094663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TD9oBr1J7/EIT0M0+rkmdoRA3UBnrqOUEqn9r3Ju3k0=;
 b=aIKsQdwK8u5GqvS1sfGOc9uzW1LWSjNIJ+GC/g6kuj9N2e9tndh3uJNVP02TDMU9k5
 5BJo+t8dcQQqIKXPU0eHb6zzZgwQgXCeLNWe8kSpIyk9k7+Sf9dgLh1QyLmUfVioAjxu
 oBOMq8mXzEwHqMs3ZgVCDBkKzQ/40u0BjHYg8exUZMuMIZF/hPodOlqgjCAN8BIK3Oz4
 rOrJwqyoUSk5S2AQAFBfiUZb1Tv1Y/mfiud/vLG7zcmyQOADLbyNBvOmlkEl3zmgOlEQ
 BnzPqV2ZuuszzzWKqtk4xQkJnXfE6LEXt+xnHw2a4cR+jP0PhUXNcKdsfUyljfp1+UjV
 /Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489863; x=1790094663;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TD9oBr1J7/EIT0M0+rkmdoRA3UBnrqOUEqn9r3Ju3k0=;
 b=sE3ribZF+RWkgLDW8/5eXEqrm+VHX9F6c5WmULPaiSUbeZEkJbBKF5u5hpgfyUGb7C
 NUx1YdwmlJLSPyFArqIne3tsW1itOAdIEHgMwqq/sWI4VcOuUFhI2MR8i0yz1RwDwqkJ
 EJuB0nna6YeioRRq8Y5tpYqJhpVGlH5pl/vjC026F+XCahf+YY9ObgpRym8yYAp98/Fj
 Ry50xEeJsykQQdw0HRucfRxV0SBdt3Sww24acO/zBdZVrejzIo0UTgvLTaD+k2KZpMOn
 V+MGroAsGNDCLHFItNebgzawxa8kikDxMETdcmyQmt5xIXw79ND8gdiRdpE2NuV6tQ+b
 9tWA==
X-Gm-Message-State: AFuF++lKi3aiUFpwFF1CW04/c5fv78lWyV8O+wvnoUW5E9JE0rNw8Isg
 2dRJFbOdxo3iU6ds+uNh1fEhfblTHceYpE+0TQ6C3N0XhJh1O7WV6GHWcV3U55UFTKss9SoujGv
 H51oArSJoH+1jCUTh+Ys+wQAGDWRP2ic5+P/m8qiOGeK3AWBT5vCHtsQXZAsuiT322w==
X-Gm-Gg: AYBFou2QoD4FHykbcohKwLX/aM5UZSTnEQoIo7w0UItt/0DS8WK4brikbnZChiGsPgu
 HuraHSEbYDu0veoxIKtzcHSBMYN8UuSOOkYAhsC5poA/mhTqIyJM6LvPI3WnLGydNB/CapgpVQL
 SQi0PJbf6rDSBmnbZQP2zMCe39INY7/VRnELDVtEeoQT0GKsvDpXJ+FF6QRPoTySqIa23rY/8uY
 BecxoTF8oo5co7Fbkl9WrHS75p8SzBi8MZewEQLnT3sK5rB3M8AP19TWcshfVNUSMrW22R4X1Q+
 hZ3h3/Es1q3odja2FDIFKfbS6OtlSLR62x8VIXWWjPKjog17+x+8E0JHfnNc3jF4fJn704+HbLo
 YywFZ21AGHkMtYEf+LbNIff8GdOl9PJorxxDlLz2eSQ4ewHOL
X-Received: by 2002:a17:90b:5850:b0:39d:fcbe:fdd2 with SMTP id
 98e67ed59e1d1-39dfcbf811dmr10527202a91.5.1789489862771; 
 Tue, 15 Sep 2026 09:31:02 -0700 (PDT)
X-Received: by 2002:a17:90b:5850:b0:39d:fcbe:fdd2 with SMTP id
 98e67ed59e1d1-39dfcbf811dmr10527144a91.5.1789489862273; 
 Tue, 15 Sep 2026 09:31:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 07/17] tests/tcg/hexagon: add bit interleave and convergent
 rounding tests
Date: Tue, 15 Sep 2026 09:30:37 -0700
Message-Id: <20260915163047.4180600-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: WOPVQB2gCff2L-SZUUTVq-N2pEK7kmQI
X-Proofpoint-GUID: WOPVQB2gCff2L-SZUUTVq-N2pEK7kmQI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX8LrHL9U4e6pD
 8HTD6xOX4xP9U6y56+F77ynEh8uM9T86KbfoVnqIsNmOECOPJrDgVp8/h3t4G8IWxkFMLs5l5ri
 B4UJpfBBUWOtEEFzne7IX1sh7feTwDs=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa972c7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=MD3S-f5BDBJKRhxJpBIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX6csT/E6ectwd
 nI2d8yhT0NAD8/NdKsiJ8YgOSLsXaSBZSsoWQWr2tvfZALNqSGxhrnjjlJcqi/U2HQ25uF+iT03
 uhOu0wVmxyRhlTfddox7RspLsr4oVLO937zyM/SFd71PD1xRe/mY+kyMUmWO++jL7jDYY8a9Mxw
 iR4W3hLRxe4IbEc7Ui813K7+slKGKgBuSG7l2m0pMBhitG/UdS4rGf40FowQfMMng7jZJpXRp6K
 fhlNgcTXmvJxmRyuaFqNcnuLFT5Vu/Yl98hHeF5UBBflwpeFGO+RGS4fwNcC2TIk8wyIRX1o8Ca
 4QzIxtSz+NDGNtwJTsIUiDstPMtbMuwqVRQGD+IELfPHnpL2ddnUIon/aigldx9iG3zM4opAaQa
 8P55e1csr/h+7m5WYWQ5yiEgNecPDIC9lYWq07luCnGJNj46vZGJs20YUgxBLJbERi3pHXt1Fpj
 jdyjk+N4MeWjEN4Bhpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150239
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

VGVzdCB0aGUgaW50ZXJsZWF2ZS9kZWludGVybGVhdmUgNjQtYml0IGJpdC1tYW5pcHVsYXRpb24g
aW5zdHJ1Y3Rpb25zCmFuZCB0aGUgY3JvdW5kIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFNp
ZCBNYW5uaW5nIDxzaWQubWFubmluZ0Bvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hl
eGFnb24vdGVzdF9iaXRvcHMuYyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICB8ICAxICsKIDIgZmlsZXMgY2hhbmdl
ZCwgOTkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29u
L3Rlc3RfYml0b3BzLmMKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2JpdG9w
cy5jIGIvdGVzdHMvdGNnL2hleGFnb24vdGVzdF9iaXRvcHMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMC4uM2U5Mjc0ZGRkZGQKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0
cy90Y2cvaGV4YWdvbi90ZXN0X2JpdG9wcy5jCkBAIC0wLDAgKzEsOTggQEAKKy8qCisgKiBDb3B5
cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlh
cmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8K
KworLyoKKyAqIFRlc3QgYml0IGludGVybGVhdmUvZGVpbnRlcmxlYXZlIGFuZCBjb252ZXJnZW50
IHJvdW5kaW5nLgorICovCisKKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5o
PgorI2luY2x1ZGUgPGhleGFnb25fcHJvdG9zLmg+CisKK2ludCBlcnI7CisKKyNpbmNsdWRlICJo
ZXhfdGVzdC5oIgorCitzdGF0aWMgdm9pZCBjaGVja19pbnRlcmxlYXZlKHZvaWQpCit7CisgICAg
dWludDY0X3QgaW5wdXQ7CisgICAgdWludDY0X3QgaW50ZXI7CisgICAgdWludDY0X3QgZGVpbnRl
cjsKKworICAgIC8qCisgICAgICogaW50ZXJsZWF2ZSB0YWtlcyB0aGUgMzIgZXZlbiBiaXRzIGFu
ZCAzMiBvZGQgYml0cyBvZiBSc3MgYW5kCisgICAgICogaW50ZXJsZWF2ZXMgdGhlbTogZXZlblsw
XSBnb2VzIHRvIGJpdCAwLCBvZGRbMF0gdG8gYml0IDEsCisgICAgICogZXZlblsxXSB0byBiaXQg
Miwgb2RkWzFdIHRvIGJpdCAzLCBldGMuCisgICAgICoKKyAgICAgKiBJbnB1dDogIGxvdyAzMiBi
aXRzIChldmVuIGhhbGYpLCBoaWdoIDMyIGJpdHMgKG9kZCBoYWxmKQorICAgICAqIElmIGxvdyA9
IDB4RkZGRkZGRkYsIGhpZ2ggPSAweDAwMDAwMDAwOgorICAgICAqICAgcmVzdWx0IGhhcyBldmVy
eSBldmVuIGJpdCBzZXQsIGV2ZXJ5IG9kZCBiaXQgY2xlYXIKKyAgICAgKiAgID0gMHg1NTU1NTU1
NTU1NTU1NTU1CisgICAgICovCisgICAgaW5wdXQgPSAweDAwMDAwMDAwRkZGRkZGRkZVTEw7Cisg
ICAgaW50ZXIgPSBRNl9QX2ludGVybGVhdmVfUChpbnB1dCk7CisgICAgY2hlY2s2NChpbnRlciwg
MHg1NTU1NTU1NTU1NTU1NTU1VUxMKTsKKworICAgIC8qIEFsbCBvbmVzIHNob3VsZCBzdGF5IGFs
bCBvbmVzICovCisgICAgaW5wdXQgPSAweEZGRkZGRkZGRkZGRkZGRkZVTEw7CisgICAgaW50ZXIg
PSBRNl9QX2ludGVybGVhdmVfUChpbnB1dCk7CisgICAgY2hlY2s2NChpbnRlciwgMHhGRkZGRkZG
RkZGRkZGRkZGVUxMKTsKKworICAgIC8qIEFsbCB6ZXJvcyBzaG91bGQgc3RheSBhbGwgemVyb3Mg
Ki8KKyAgICBpbnB1dCA9IDB4MDAwMDAwMDAwMDAwMDAwMFVMTDsKKyAgICBpbnRlciA9IFE2X1Bf
aW50ZXJsZWF2ZV9QKGlucHV0KTsKKyAgICBjaGVjazY0KGludGVyLCAweDAwMDAwMDAwMDAwMDAw
MDBVTEwpOworCisgICAgLyoKKyAgICAgKiBkZWludGVybGVhdmUgaXMgdGhlIGludmVyc2Ugb2Yg
aW50ZXJsZWF2ZS4KKyAgICAgKiBkZWludGVybGVhdmUoaW50ZXJsZWF2ZSh4KSkgc2hvdWxkIGVx
dWFsIHguCisgICAgICovCisgICAgaW5wdXQgPSAweERFQURCRUVGQ0FGRUJBQkVVTEw7CisgICAg
aW50ZXIgPSBRNl9QX2ludGVybGVhdmVfUChpbnB1dCk7CisgICAgZGVpbnRlciA9IFE2X1BfZGVp
bnRlcmxlYXZlX1AoaW50ZXIpOworICAgIGNoZWNrNjQoZGVpbnRlciwgaW5wdXQpOworCisgICAg
LyogZGVpbnRlcmxlYXZlIG9mIDB4NTU1NS4uLjU1NTUgLT4gbG93IGhhbGYgYWxsIDFzLCBoaWdo
IGhhbGYgYWxsIDBzICovCisgICAgZGVpbnRlciA9IFE2X1BfZGVpbnRlcmxlYXZlX1AoMHg1NTU1
NTU1NTU1NTU1NTU1VUxMKTsKKyAgICBjaGVjazY0KGRlaW50ZXIsIDB4MDAwMDAwMDBGRkZGRkZG
RlVMTCk7Cit9CisKK3N0YXRpYyB2b2lkIGNoZWNrX2Nyb3VuZCh2b2lkKQoreworICAgIC8qCisg
ICAgICogY3JvdW5kKDB4MzAwLCAjOCkgLT4gMyAoZXhhY3Qgc2hpZnQsIG5vIHJvdW5kaW5nIG5l
ZWRlZCkuCisgICAgICogMHgzMDAgPj4gOCA9IDMKKyAgICAgKi8KKyAgICBjaGVjazMyKFE2X1Jf
Y3JvdW5kX1JJKDB4MzAwLCA4KSwgMyk7CisKKyAgICAvKgorICAgICAqIGNyb3VuZCgweDM4MCwg
IzgpIC0+IDQgKDB4MzgwID4+IDggPSAzLjUsIHJvdW5kcyB0byBldmVuID0gNCkKKyAgICAgKi8K
KyAgICBjaGVjazMyKFE2X1JfY3JvdW5kX1JJKDB4MzgwLCA4KSwgNCk7CisKKyAgICAvKgorICAg
ICAqIGNyb3VuZCgweDI4MCwgIzgpIC0+IDIgKDB4MjgwID4+IDggPSAyLjUsIHJvdW5kcyB0byBl
dmVuID0gMikKKyAgICAgKi8KKyAgICBjaGVjazMyKFE2X1JfY3JvdW5kX1JJKDB4MjgwLCA4KSwg
Mik7CisKKyAgICAvKgorICAgICAqIGNyb3VuZCgweDNDMCwgIzgpIC0+IDQgKDB4M0MwID4+IDgg
PSAzLjc1LCByb3VuZHMgdXAgdG8gNCkKKyAgICAgKi8KKyAgICBjaGVjazMyKFE2X1JfY3JvdW5k
X1JJKDB4M0MwLCA4KSwgNCk7CisKKyAgICAvKgorICAgICAqIFNoaWZ0IGJ5IDAgLT4gcmV0dXJu
IHRoZSBpbnB1dCB1bmNoYW5nZWQuCisgICAgICovCisgICAgY2hlY2szMihRNl9SX2Nyb3VuZF9S
SSg0MiwgMCksIDQyKTsKK30KKworaW50IG1haW4odm9pZCkKK3sKKyAgICBjaGVja19pbnRlcmxl
YXZlKCk7CisgICAgY2hlY2tfY3JvdW5kKCk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQ
QVNTIik7CisgICAgcmV0dXJuIGVyciA/IDEgOiAwOworfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNn
L2hleGFnb24vbWVzb24uYnVpbGQgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRl
eCA2ZTM2YTlhMTIyMC4uZTk1MDk2YzFhNDkgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29u
L21lc29uLmJ1aWxkCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC02OSw2
ICs2OSw3IEBAIHRlc3RzICs9IHsKICAgJ3Rlc3RfYWJzLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdz
fSwKICAgJ3Rlc3RfYml0Y250LlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfYml0
c3BsaXQuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAorICAndGVzdF9iaXRvcHMuYyc6IHsnY2Zs
YWdzJzogY2ZsYWdzfSwKICAgJ3Rlc3RfY2FsbC5TJzogeydjZmxhZ3MnOiBhc21mbGFnc30sCiAg
ICd0ZXN0X2Nsb2JiZXIuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9jbXAuUyc6
IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAotLSAKMi4zNC4xCgo=

