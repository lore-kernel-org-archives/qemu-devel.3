Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C5606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ktSL0O07;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N/A3U9Mg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIzN-0003kA-7a; Wed, 25 Nov 2026 14:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzL-0003j1-6e
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzJ-0006Ld-Cb
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:06 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APJB8wZ1794605
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yPN3vaESmi6TSfYbX62X7QvvA+aB0PCG5fGD884G5Ss=; b=ktSL0O07UGtHW9mW
 G8om/K282Leml1d3XEIBbLVXHiHWPa/ULUy/9AGSOuKnQ5yIo9mVxziJgjc+9uZy
 Bh7nQMf34J3rLMoN9ix7gtPUuR+F7E2h1H1Qk9IsNMap1koOPewcj78GYtSmtEef
 8M9p3XSh0Wdx8+BQNHtxXawr0thsMSPlCKi5naqLmVjqk38iuvgZCqo6jjq8igAb
 31SEx1dJJXLzxSXARMNbeDNlprizaRU0MspkLHYQ5GL4UEJGbLxTpT9hAyaUkdIP
 TFzdmw+El3usxYmSi/iUpdNOuQiXWl1znLyi102O0LY1QDJ7zcSvx6zbVLmKhuag
 E0/z5g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnth1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:49:03 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso1637647c88.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795636142; x=1796240942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yPN3vaESmi6TSfYbX62X7QvvA+aB0PCG5fGD884G5Ss=;
 b=N/A3U9MgKYgEzHNtEEiT4CSSzFQpeNn/wc1yxi1qCbEmKLPCfF/9m+2jdw7kuKkAyi
 YTBzokEQP/PvpCzghkPp/7SyOZsZk0NMHid1oQ04vXrDgz/oOIaNdYNtS0IObjlrj1bM
 vxqganNHX8LYZRiqfTYtXOFflOjnsL64S7xOM1+7naBBWqWhGvJLAfSpoOSFDdKKJA84
 alTQRzKEM7aUcI+o/oY6jpnDX0+Fz9wZ8FICRJfqBE3I2mQvu/ZaoJeepg3Yff+LuBrE
 7uwSuRrA3JzVcqeDYosIY+QlFYTq7BJWPN5eaXqkMLl1q8M3NHAlxjTVjmfU3Rxchv9I
 uT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795636142; x=1796240942;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yPN3vaESmi6TSfYbX62X7QvvA+aB0PCG5fGD884G5Ss=;
 b=s6fT1GRzAY7svbWsj2Ahr8OlpVg9vbeycBgYvMDau7NW8TZFAO9Pw1/NDJYJ6/DogN
 BGQDx0jPr5bobNcNVVw5AAirKKyJMcoNTXM7ZqrjFG/kwreZbFvyWVjgNtJvTBulQvm3
 Y28iMmHziEcqOwHBz9WQvv1rK1xR+t+LKDw7vlKIaGRChwUdV41sSKus4+RopoCmHWm2
 4KV2q31D/5JmoFEYQysc8caoeFpdyEncUNGTiDKQ7RTmcpdD6M8aJ/8Hw0Y6gto2P46G
 widTPoZbCuMSJqKGWvN0e4JARnenC9oxG2FA95e/ZvQ/sxY1V5fIg+260YZfcvJV4HkB
 UG5Q==
X-Gm-Message-State: APuU4Z+Qh3VzuxZtR1y0gL64mpWDeksXhCAyL4UDJErpTVTPVn/Xsg+i
 qwOjOFj1S0aNL3fCBpqH0v/LV69Zgs23FFl9kINVktflrniDjZJYevosHZ7f24S4ArxxJ3baXPr
 383OQ18mHPGiiiAe0yz0dxNJK4sliu/nQe0f7370YOocIaNi5qloASonoQ30b2Bao9g==
X-Gm-Gg: AZFdTZcZvIlwuFATvh9dZybtem8PsWZSQPOUI1bo2VdmYTVTB+IQao0D09eFPJIUXRj
 AjQxfoSyHeDpusBk9p8B2fhdZoX49k89UVwLqPwv7/kyTlfht1C3r6k2y2YLpOOBIMP3sQp7V4h
 0+uDBSGzHXI0l15xD34j5nz2jB7M+cv10ZrDauyx2v3DcAiYH7fzu8sLw9OaHGbc7KIMgStGE2X
 W1Cx5D4aoThgO6FbVaC1HRLoe3aTMw60mrOLCQ3bPvMG8PYBpqEpswlickx3aC/TcKQIXcEby2w
 qyGgYUPN8609b42ekfcqe6XQbij9Kz210ExVfeAcB2iF9nS8r7dHoclpqkurgJJamjRUrfTB2w/
 UnPXdcCSVpY4ZyPcP/CGizDfUwSxJBIPcwvCqdTs/06jCDW8zNcHoMrI63OUsB1d2H9lj1dm/TB
 NCgpm+z4jXLY9upm3J3Ss1rw==
X-Received: by 2002:a05:7022:38b:b0:1b5:2dce:1b6d with SMTP id
 a92af1059eb24-1b55689ab30mr22689412c88.17.1795636142400; 
 Wed, 25 Nov 2026 11:49:02 -0800 (PST)
X-Received: by 2002:a05:7022:38b:b0:1b5:2dce:1b6d with SMTP id
 a92af1059eb24-1b55689ab30mr22689379c88.17.1795636141818; 
 Wed, 25 Nov 2026 11:49:01 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm44407715c88.12.2026.11.25.11.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:49:01 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-12.0 3/5] linux-user: let targets add notes to core dumps
Date: Wed, 25 Nov 2026 11:48:53 -0800
Message-Id: <20261125194855.3154845-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfXxvUFVnl6kPxf
 ds8lCAdCF/PTARMNV74rAPlziQQKYko2Z4R9zPFWyu6plv6Quur++q/npJL3iMHtCJsyeSlQI4t
 Hb7AT5jqL2D9HH08AIPPKd6JZ4HsVmfQflt9VpYUXdoX2XrzJJvqTr25kuSE9FQEuAgaa2IlQVQ
 J2tHz4rsRBzRheBEILS+o67d5y2GRKhX7IaRBXnyyiSDttzzeumYwNivyrJNJqPgcVVMg8cZGnd
 R5uV81sonNOMtvh2T7tbnsKAYIdxsePXoFAZ4K9ZJfWMYQHdgl1D5/U7sYIWkj0Y2nZQEmwUI9s
 agILJ4cDwzUw0mvJrvuEH9R9DzKNBfgZVf1OvsULdn2ZRz6oSlFfT5x1zq8Bgx3iBvZx5Mpt2qh
 DafFQu5lZzR2fI5Oq8IKx8aRwK5YwkwRVRfilHSSRogClogZflttVEVkLLZBZEo5+/nPg7OVxOr
 880tTjYGj4GhjZYm01g==
X-Proofpoint-ORIG-GUID: TtYKyVR7kP975yYJxPpKc4e2Cphc_2Tw
X-Proofpoint-GUID: TtYKyVR7kP975yYJxPpKc4e2Cphc_2Tw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX7VhSRBEkm9Kr
 8SVI0PETbGhsd4BduJeL99+XmZtKifbqp+6LsbE+mTRqeMTri4IGnbSFVUJKPKvl7zLfTxBMagU
 /Qry8XtqaotlILHHer1jDFWQF7KYzto=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b073baf cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QP29ThLKEn_V7VGjd4QA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250078
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

VGhlIGxpbnV4LXVzZXIgY29yZSB3cml0ZXIgb25seSBlbWl0cyBOVF9QUlNUQVRVUyBhbmQsIGZv
ciBzb21lIHRhcmdldHMsCk5UX0ZQUkVHU0VUIGZvciBlYWNoIHRocmVhZC4gIFRhcmdldHMgd2l0
aCBhZGRpdGlvbmFsIGFyY2hpdGVjdHVyYWwKc3RhdGUsIHN1Y2ggYXMgdmVjdG9yIGNvcHJvY2Vz
c29yIHJlZ2lzdGVycywgaGF2ZSBubyB3YXkgdG8gaW5jbHVkZSBpdC4KCkFkZCBhbiBvcHRpb25h
bCBIQVZFX0VMRl9DT1JFX0VYVFJBX05PVEVTIGhvb2suICBUaGlzIHdpbGwgYmUgbGV2ZXJhZ2Vk
IGJ5CmhleGFnb24gaW4gZm9sbG93aW5nIGNvbW1pdHMuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogbGludXgtdXNlci9sb2FkZXIu
aCAgfCAgOSArKysrKysrKysKIGxpbnV4LXVzZXIvZWxmbG9hZC5jIHwgMTQgKysrKysrKysrKysr
KysKIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4
LXVzZXIvbG9hZGVyLmggYi9saW51eC11c2VyL2xvYWRlci5oCmluZGV4IDVkZGQxNDAyNzZjLi5j
OTM1ZDI3ZDBhNSAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9sb2FkZXIuaAorKysgYi9saW51eC11
c2VyL2xvYWRlci5oCkBAIC0xMTIsNiArMTEyLDE1IEBAIHZvaWQgZWxmX2NvcmVfY29weV9yZWdz
KHN0cnVjdCB0YXJnZXRfZWxmX2dyZWdzZXRfdCAqLCBjb25zdCBDUFVBcmNoU3RhdGUgKik7CiAv
KiBPbmx5IGRlZmluZWQgYnkgYSB0YXJnZXQgd2hvc2UgdGFyZ2V0X2VsZi5oIHNldHMgSEFWRV9F
TEZfQ09SRV9GUFJFR1MuICovCiBzdHJ1Y3QgdGFyZ2V0X2VsZl9mcHJlZ3NldF90Owogdm9pZCBl
bGZfY29yZV9jb3B5X2ZwcmVncyhzdHJ1Y3QgdGFyZ2V0X2VsZl9mcHJlZ3NldF90ICosIGNvbnN0
IENQVUFyY2hTdGF0ZSAqKTsKKy8qCisgKiBPbmx5IGRlZmluZWQgYnkgYSB0YXJnZXQgd2hvc2Ug
dGFyZ2V0X2VsZi5oIHNldHMgSEFWRV9FTEZfQ09SRV9FWFRSQV9OT1RFUy4KKyAqIFRoZSBub3Rl
cyBmb2xsb3cgdGhlIHRocmVhZCdzIE5UX1BSU1RBVFVTIChhbmQgTlRfRlBSRUdTRVQpIG5vdGUu
CisgKiBlbGZfY29yZV9leHRyYV9ub3Rlc19zaXplKCkgcmV0dXJucyB0aGUgc2l6ZSBpbiBieXRl
cyBvZiB0aGUgY29tcGxldGUsCisgKiA0LWJ5dGUgYWxpZ25lZCBFTEYgbm90ZXMgdGhhdCBlbGZf
Y29yZV9maWxsX2V4dHJhX25vdGVzKCkgc3RvcmVzIGluIHRoZQorICogYnVmZmVyIGZvciB0aGUg
c2FtZSBDUFUuCisgKi8KK3NpemVfdCBlbGZfY29yZV9leHRyYV9ub3Rlc19zaXplKGNvbnN0IENQ
VUFyY2hTdGF0ZSAqKTsKK3ZvaWQgZWxmX2NvcmVfZmlsbF9leHRyYV9ub3Rlcyh2b2lkICpidWYs
IGNvbnN0IENQVUFyY2hTdGF0ZSAqKTsKIAogdHlwZWRlZiBzdHJ1Y3QgewogICAgIGNvbnN0IHVp
bnQ4X3QgKmltYWdlOwpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9lbGZsb2FkLmMgYi9saW51eC11
c2VyL2VsZmxvYWQuYwppbmRleCBjMTg4ZmEwM2MzMS4uOTNiYjhiMGJiODggMTAwNjQ0Ci0tLSBh
L2xpbnV4LXVzZXIvZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVzZXIvZWxmbG9hZC5jCkBAIC0xNzE3
LDYgKzE3MTcsMTEgQEAgaW50IGxvYWRfZWxmX2JpbmFyeShzdHJ1Y3QgbGludXhfYmlucHJtICpi
cHJtLCBzdHJ1Y3QgaW1hZ2VfaW5mbyAqaW5mbykKICAqICAgICBlbnYgLSBjb3B5IHJlZ2lzdGVy
cyBmcm9tIGhlcmUKICAqCiAgKiBFeGFtcGxlIGZvciBBUk0gdGFyZ2V0IGlzIHByb3ZpZGVkIGlu
IHRoaXMgZmlsZS4KKyAqCisgKiBBIHRhcmdldCB0aGF0IGhhcyBtb3JlIHBlci10aHJlYWQgc3Rh
dGUgd29ydGggZHVtcGluZyBjYW4gYWxzbyBkZWZpbmUKKyAqIEhBVkVfRUxGX0NPUkVfRVhUUkFf
Tk9URVMgYW5kIGltcGxlbWVudCBlbGZfY29yZV9leHRyYV9ub3Rlc19zaXplKCkgYW5kCisgKiBl
bGZfY29yZV9maWxsX2V4dHJhX25vdGVzKCksIHRvIGFkZCBub3RlcyBvZiBpdHMgb3duIGFmdGVy
IGVhY2ggdGhyZWFkJ3MKKyAqIE5UX1BSU1RBVFVTIG5vdGUuCiAgKi8KIAogc3RydWN0IHRhcmdl
dF9lbGZfc2lnaW5mbyB7CkBAIC0yMTgzLDYgKzIxODgsMTEgQEAgc3RhdGljIGludCBlbGZfY29y
ZV9kdW1wKGludCBzaWduciwgY29uc3QgQ1BVQXJjaFN0YXRlICplbnYpCiAgICAgb2Zmc2V0ICs9
IHNpemVfbm90ZSgiQ09SRSIsIHNpemVvZihzdHJ1Y3QgdGFyZ2V0X2VsZl9wcnN0YXR1cykpICog
Y3B1czsKICNpZmRlZiBIQVZFX0VMRl9DT1JFX0ZQUkVHUwogICAgIG9mZnNldCArPSBzaXplX25v
dGUoIkNPUkUiLCBzaXplb2YodGFyZ2V0X2VsZl9mcHJlZ3NldF90KSkgKiBjcHVzOworI2VuZGlm
CisjaWZkZWYgSEFWRV9FTEZfQ09SRV9FWFRSQV9OT1RFUworICAgIENQVV9GT1JFQUNIKGNwdV9p
dGVyKSB7CisgICAgICAgIG9mZnNldCArPSBlbGZfY29yZV9leHRyYV9ub3Rlc19zaXplKGNwdV9l
bnYoY3B1X2l0ZXIpKTsKKyAgICB9CiAjZW5kaWYKICAgICBub3RlX3NpemUgPSBvZmZzZXQgLSBu
b3RlX29mZnNldDsKICAgICBkYXRhX29mZnNldCA9IFRBUkdFVF9QQUdFX0FMSUdOKG9mZnNldCk7
CkBAIC0yMjQ1LDYgKzIyNTUsMTAgQEAgc3RhdGljIGludCBlbGZfY29yZV9kdW1wKGludCBzaWdu
ciwgY29uc3QgQ1BVQXJjaFN0YXRlICplbnYpCiAgICAgICAgICAgICBkcHRyID0gZmlsbF9ub3Rl
KCZocHRyLCBOVF9GUFJFR1NFVCwgIkNPUkUiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzaXplb2YodGFyZ2V0X2VsZl9mcHJlZ3NldF90KSk7CiAgICAgICAgICAgICBmaWxsX2ZwcmVn
c2V0X25vdGUoZHB0ciwgY3B1X2l0ZXIpOworI2VuZGlmCisjaWZkZWYgSEFWRV9FTEZfQ09SRV9F
WFRSQV9OT1RFUworICAgICAgICAgICAgZWxmX2NvcmVfZmlsbF9leHRyYV9ub3RlcyhocHRyLCBj
cHVfZW52KGNwdV9pdGVyKSk7CisgICAgICAgICAgICBocHRyICs9IGVsZl9jb3JlX2V4dHJhX25v
dGVzX3NpemUoY3B1X2VudihjcHVfaXRlcikpOwogI2VuZGlmCiAgICAgICAgIH0KIAotLSAKMi4z
NC4xCgo=

