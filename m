Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E298606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TbVZL8OA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGRy9SBP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX2cI-0002tH-1e; Fri, 27 Nov 2026 15:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cG-0002sm-K1
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cE-00025n-Ir
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:20 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJCFL43984365
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e2oOpjIR/volTF3ijNmt/u7efTWHN/46JPiG3ZB3Fmk=; b=TbVZL8OAHnZPaJJi
 DxIPmXtA30CLKgI+NwVfD24lE5jh25pmSTAWbvQ2GzNtDj4O9bomq+am4I7eegPs
 IHct/Gx5IL8lN99eUwtLiZ0GehVTvBXghonIuwUa08Cp8mNWxvcanXmqoDqnzcyh
 AboKy3BjdgatbXtso7a6edL1lnMSq/ULXKOWbJZUbOiUJKKYv+0x/QEqbh0urrFq
 JtjVtIb3334u1S7ibFC5WYzx+PQpvWeYEojYwc/4HF5se51MrvLvayHoCsxNpyoK
 nsN91X4VKCM6tjN7PD7m1yETH9oq7T7u04J6rgqePEESbXw7Tq97UsQmOXsSjrp+
 DNXKjw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7f6d8918-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so5934900c88.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811536; x=1796416336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e2oOpjIR/volTF3ijNmt/u7efTWHN/46JPiG3ZB3Fmk=;
 b=RGRy9SBPP8JgdoLxj6omucnDLkU7NGI+i3XxhuhPF26kaeRZ+ai3mSCpBBUNifzbst
 RBGTLY1VXHLduyYyILxBUMEC87N+9hT1aXu6U+XGmo/IkaSnnJs88Km/FamJefOtGcNh
 1jpHtvuC4QytYsCC1u7f4FgIPVvJcHbJnrt/BM9nVxkURihdFnOd5KS1yHqURaGwT/RV
 /uFOa3O/zhsRg/HkDb5peZ6RkkSOx6RsM7EKlvKsO6+fM+JXzZ7q7XpJm0l5XaVrJ05o
 1Nizy7sTdhx10ewT4MKr+CuXr+hpvSy6Nhsi2GlYPJ/rYlU2pZZLHIVYhpSSPKLWZOVJ
 dCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811536; x=1796416336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e2oOpjIR/volTF3ijNmt/u7efTWHN/46JPiG3ZB3Fmk=;
 b=DHKwUagUGfqCIb3XbCActXiODjT56BkFL3PpGQ3+n0DTpa0OwlMfqrxlg7Z1Xcq46z
 Zbhoj3ULzDi7nInZQWilCSb6GQkBDuIZKgj4tfWhh3/yVv5I2rcv3eG2oWN2KVBLs52D
 SunrfTVkaqGLy+h7Z2jdvRz+AJ1TG4tzy928j/RHnEgXZvPgrWQbfDwqDR8S8g7x3m4n
 eqtZruHd1yCiW7XQiBg0UEFHZDXPmvkVINs2lA6yAzi9S2lwtRHMUwrxI67ko4HGMU+7
 AVQZqlF7rRimpihpjvFq+paj0EkBYupBWsqXg8nMHMh5HfssXQ/4qWCVdLRDnJzJ0IPN
 ph3A==
X-Gm-Message-State: APuU4Z8lIGj55QsABFotou6GjR3POowr7bnz5789gEeK9qpLqA5PZnTl
 Pl80ejN3ZMqRTXivZ3Z+RJbJRNpKv3sVe+bkIrran0QM4RGSjZBuoeCYN4IajfE4Cc+Pco1+Hfy
 E4M2C7ytxV/1ocNbql+I95C0pCF+ZwhsAApSFSjfxCPo6fx2MP6tTrF/iWeuOHXkf8g==
X-Gm-Gg: AZFdTZf4lKteP4AzzRKoimjYFOUWZ4WDJTNuqmLNHNa+pgYXNndqe0NrFztw/E/vtaX
 /UM7uSYc2+8JUyFZ/JPxBNVMwPkFQzhi/9t6NaVlT1YrwF0cqJaMCc7ENcAUbiVNc1Y9IpH+fOy
 ArDmt4cI0ml4O4Lt3j5wV2/ZX3wMeecD6sZ5riGf9ABLqZEGt9MR+DD8el62bAuuZmzREq2PFVZ
 cBIp3OdPgIV2O9Tzz/wGbAfqs+dqlBFcE3oyfIDQ+UB2omM+EscnCtOgRm+gyY/zrTqnCAQIjuM
 JPgi/o/vl8BnVLk8csE+JSTCvXqjkkYDMCFmaA6IgzS22E8lkoOEe44bDKidKoujtrRQ1jKXwJW
 Ip6/WP9SJLDWt+2ymLq+W6edPfsA6aacttQUuxK5OokUAeXP3TNZffm7jg6RnTtAZQFseOohVdJ
 enOikJQU36JpjJ/isefK7j
X-Received: by 2002:a05:701a:cc84:10b0:1b5:709f:d510 with SMTP id
 a92af1059eb24-1b5709fd63fmr17893176c88.22.1795811535738; 
 Fri, 27 Nov 2026 12:32:15 -0800 (PST)
X-Received: by 2002:a05:701a:cc84:10b0:1b5:709f:d510 with SMTP id
 a92af1059eb24-1b5709fd63fmr17893151c88.22.1795811535260; 
 Fri, 27 Nov 2026 12:32:15 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55681301asm59248021c88.8.2026.11.27.12.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:32:13 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH for-12.0 v2 3/5] linux-user: let targets add notes to core
 dumps
Date: Fri, 27 Nov 2026 12:32:07 -0800
Message-Id: <20261127203209.42752-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
References: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: RmHvsAc_XEwKEL1gDe2NVhIqH9QaTkwq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfXynZ1Km5VylpD
 cfU+8XAXi07d/PDsos4cK4ynuHLAs+KNS4R+QBAbYkGllRZfPKAsyPIAR3tgkRGJ1M8w1wImIMb
 5M55T08yxLNKtyF8gyBMEz0Eak32yIo=
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6b09e8d0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QP29ThLKEn_V7VGjd4QA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: RmHvsAc_XEwKEL1gDe2NVhIqH9QaTkwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX9KEkHMX0CXIu
 UJhjObdRZ1n6C/G7+sx6Adwe9CKtXHbEXQtSKOMbjoxZrwqW8CfRw/75iB0hLj0RfjmnFyNtVYj
 cKFvPtM4/alrWNy9MrqxTGRqBjo4itY6RJQtw80Ne4l2WUr7borjN793GUQ3oSgekHTUdlPzqHs
 YPtvMYJJJz05staWG//7xaSzi0tnIa3FNU+ix4cYaGhklPqbgZi0JmHlOLrLRy6QfXYnKjZflRf
 TgLX7ymMEAPC0MZDNqoyMfPr3emPbn1unCwG0/ZkHk1PIqz8MSAuvnxLHRD/fjqIA9RLrn548pN
 1AQD6mDxFsbUoXDfJ0WUD0NiXXXEp3ueCY205Hdxxm055VNdzHVWcDH+gHzngADM6aDss4i1SWK
 WFt5JHIwwurI2EbxaLVdUF6tN/gJab+EAJ+NSYiNv7oLVlSt76EGF/wQr1IMEBc5aI5D9Jop7xe
 oaPunb+7nvqYSwiRu3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
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

VGhlIGxpbnV4LXVzZXIgY29yZSB3cml0ZXIgb25seSBlbWl0cyBOVF9QUlNUQVRVUyBhbmQsIGZv
ciBzb21lIHRhcmdldHMsCk5UX0ZQUkVHU0VUIGZvciBlYWNoIHRocmVhZC4gIFRhcmdldHMgd2l0
aCBhZGRpdGlvbmFsIGFyY2hpdGVjdHVyYWwKc3RhdGUsIHN1Y2ggYXMgdmVjdG9yIGNvcHJvY2Vz
c29yIHJlZ2lzdGVycywgaGF2ZSBubyB3YXkgdG8gaW5jbHVkZSBpdC4KCkFkZCBhbiBvcHRpb25h
bCBIQVZFX0VMRl9DT1JFX0VYVFJBX05PVEVTIGhvb2suICBUaGlzIHdpbGwgYmUgbGV2ZXJhZ2Vk
IGJ5CmhleGFnb24gaW4gZm9sbG93aW5nIGNvbW1pdHMuCgpSZXZpZXdlZC1ieTogSGVsZ2UgRGVs
bGVyIDxkZWxsZXJAZ214LmRlPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogbGludXgtdXNlci9sb2FkZXIuaCAgfCAg
OSArKysrKysrKysKIGxpbnV4LXVzZXIvZWxmbG9hZC5jIHwgMTQgKysrKysrKysrKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIv
bG9hZGVyLmggYi9saW51eC11c2VyL2xvYWRlci5oCmluZGV4IDVkZGQxNDAyNzZjLi5jOTM1ZDI3
ZDBhNSAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9sb2FkZXIuaAorKysgYi9saW51eC11c2VyL2xv
YWRlci5oCkBAIC0xMTIsNiArMTEyLDE1IEBAIHZvaWQgZWxmX2NvcmVfY29weV9yZWdzKHN0cnVj
dCB0YXJnZXRfZWxmX2dyZWdzZXRfdCAqLCBjb25zdCBDUFVBcmNoU3RhdGUgKik7CiAvKiBPbmx5
IGRlZmluZWQgYnkgYSB0YXJnZXQgd2hvc2UgdGFyZ2V0X2VsZi5oIHNldHMgSEFWRV9FTEZfQ09S
RV9GUFJFR1MuICovCiBzdHJ1Y3QgdGFyZ2V0X2VsZl9mcHJlZ3NldF90Owogdm9pZCBlbGZfY29y
ZV9jb3B5X2ZwcmVncyhzdHJ1Y3QgdGFyZ2V0X2VsZl9mcHJlZ3NldF90ICosIGNvbnN0IENQVUFy
Y2hTdGF0ZSAqKTsKKy8qCisgKiBPbmx5IGRlZmluZWQgYnkgYSB0YXJnZXQgd2hvc2UgdGFyZ2V0
X2VsZi5oIHNldHMgSEFWRV9FTEZfQ09SRV9FWFRSQV9OT1RFUy4KKyAqIFRoZSBub3RlcyBmb2xs
b3cgdGhlIHRocmVhZCdzIE5UX1BSU1RBVFVTIChhbmQgTlRfRlBSRUdTRVQpIG5vdGUuCisgKiBl
bGZfY29yZV9leHRyYV9ub3Rlc19zaXplKCkgcmV0dXJucyB0aGUgc2l6ZSBpbiBieXRlcyBvZiB0
aGUgY29tcGxldGUsCisgKiA0LWJ5dGUgYWxpZ25lZCBFTEYgbm90ZXMgdGhhdCBlbGZfY29yZV9m
aWxsX2V4dHJhX25vdGVzKCkgc3RvcmVzIGluIHRoZQorICogYnVmZmVyIGZvciB0aGUgc2FtZSBD
UFUuCisgKi8KK3NpemVfdCBlbGZfY29yZV9leHRyYV9ub3Rlc19zaXplKGNvbnN0IENQVUFyY2hT
dGF0ZSAqKTsKK3ZvaWQgZWxmX2NvcmVfZmlsbF9leHRyYV9ub3Rlcyh2b2lkICpidWYsIGNvbnN0
IENQVUFyY2hTdGF0ZSAqKTsKIAogdHlwZWRlZiBzdHJ1Y3QgewogICAgIGNvbnN0IHVpbnQ4X3Qg
KmltYWdlOwpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9lbGZsb2FkLmMgYi9saW51eC11c2VyL2Vs
ZmxvYWQuYwppbmRleCBjMTg4ZmEwM2MzMS4uOTNiYjhiMGJiODggMTAwNjQ0Ci0tLSBhL2xpbnV4
LXVzZXIvZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVzZXIvZWxmbG9hZC5jCkBAIC0xNzE3LDYgKzE3
MTcsMTEgQEAgaW50IGxvYWRfZWxmX2JpbmFyeShzdHJ1Y3QgbGludXhfYmlucHJtICpicHJtLCBz
dHJ1Y3QgaW1hZ2VfaW5mbyAqaW5mbykKICAqICAgICBlbnYgLSBjb3B5IHJlZ2lzdGVycyBmcm9t
IGhlcmUKICAqCiAgKiBFeGFtcGxlIGZvciBBUk0gdGFyZ2V0IGlzIHByb3ZpZGVkIGluIHRoaXMg
ZmlsZS4KKyAqCisgKiBBIHRhcmdldCB0aGF0IGhhcyBtb3JlIHBlci10aHJlYWQgc3RhdGUgd29y
dGggZHVtcGluZyBjYW4gYWxzbyBkZWZpbmUKKyAqIEhBVkVfRUxGX0NPUkVfRVhUUkFfTk9URVMg
YW5kIGltcGxlbWVudCBlbGZfY29yZV9leHRyYV9ub3Rlc19zaXplKCkgYW5kCisgKiBlbGZfY29y
ZV9maWxsX2V4dHJhX25vdGVzKCksIHRvIGFkZCBub3RlcyBvZiBpdHMgb3duIGFmdGVyIGVhY2gg
dGhyZWFkJ3MKKyAqIE5UX1BSU1RBVFVTIG5vdGUuCiAgKi8KIAogc3RydWN0IHRhcmdldF9lbGZf
c2lnaW5mbyB7CkBAIC0yMTgzLDYgKzIxODgsMTEgQEAgc3RhdGljIGludCBlbGZfY29yZV9kdW1w
KGludCBzaWduciwgY29uc3QgQ1BVQXJjaFN0YXRlICplbnYpCiAgICAgb2Zmc2V0ICs9IHNpemVf
bm90ZSgiQ09SRSIsIHNpemVvZihzdHJ1Y3QgdGFyZ2V0X2VsZl9wcnN0YXR1cykpICogY3B1czsK
ICNpZmRlZiBIQVZFX0VMRl9DT1JFX0ZQUkVHUwogICAgIG9mZnNldCArPSBzaXplX25vdGUoIkNP
UkUiLCBzaXplb2YodGFyZ2V0X2VsZl9mcHJlZ3NldF90KSkgKiBjcHVzOworI2VuZGlmCisjaWZk
ZWYgSEFWRV9FTEZfQ09SRV9FWFRSQV9OT1RFUworICAgIENQVV9GT1JFQUNIKGNwdV9pdGVyKSB7
CisgICAgICAgIG9mZnNldCArPSBlbGZfY29yZV9leHRyYV9ub3Rlc19zaXplKGNwdV9lbnYoY3B1
X2l0ZXIpKTsKKyAgICB9CiAjZW5kaWYKICAgICBub3RlX3NpemUgPSBvZmZzZXQgLSBub3RlX29m
ZnNldDsKICAgICBkYXRhX29mZnNldCA9IFRBUkdFVF9QQUdFX0FMSUdOKG9mZnNldCk7CkBAIC0y
MjQ1LDYgKzIyNTUsMTAgQEAgc3RhdGljIGludCBlbGZfY29yZV9kdW1wKGludCBzaWduciwgY29u
c3QgQ1BVQXJjaFN0YXRlICplbnYpCiAgICAgICAgICAgICBkcHRyID0gZmlsbF9ub3RlKCZocHRy
LCBOVF9GUFJFR1NFVCwgIkNPUkUiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
b2YodGFyZ2V0X2VsZl9mcHJlZ3NldF90KSk7CiAgICAgICAgICAgICBmaWxsX2ZwcmVnc2V0X25v
dGUoZHB0ciwgY3B1X2l0ZXIpOworI2VuZGlmCisjaWZkZWYgSEFWRV9FTEZfQ09SRV9FWFRSQV9O
T1RFUworICAgICAgICAgICAgZWxmX2NvcmVfZmlsbF9leHRyYV9ub3RlcyhocHRyLCBjcHVfZW52
KGNwdV9pdGVyKSk7CisgICAgICAgICAgICBocHRyICs9IGVsZl9jb3JlX2V4dHJhX25vdGVzX3Np
emUoY3B1X2VudihjcHVfaXRlcikpOwogI2VuZGlmCiAgICAgICAgIH0KIAotLSAKMi4zNC4xCgo=

