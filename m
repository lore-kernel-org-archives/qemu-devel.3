Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8236C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwV9t-0008Kr-Tp; Tue, 18 Aug 2026 21:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9s-0008KJ-Dw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9q-0008DI-V1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkULC3326000
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2htJV3Qn9nRSsGNPzVxPWrsaM+ncItU2iqHptaT2vP4=; b=V780oYgL69eho2yX
 VBJRg+gzaKDUdrDKyPlTMu9RU2NPSl4dJ7rVNYwPdexZ+kViGvWtiO3da7lWL54F
 TIWJukHBr9xr6cp+NwfW3WtEOsR9s/wX6vCyjUQHYSCMtXWUhcj8VWD7WrX/6Mc1
 rWhmBqUoRYbf1QEYyEW3Nno+Mql7d69UlF9l87mQgB6u0tiPGti4UUHtbNlfZUBo
 cx3eodKFvRf/TwCfPv0T9j9Uk1vhn3hyBAxVUYuHDUPTOdwTO4a/piWvjP7IN5aa
 OYtJvJlVYwgPe5D2TgP1K4qZ3RHKWJs/L0CRwrBbR1h5z7aGdA2HIKCWCHGv5Rfx
 j0xUgg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfprq8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so1136736a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103117; x=1787707917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2htJV3Qn9nRSsGNPzVxPWrsaM+ncItU2iqHptaT2vP4=;
 b=VNJOgTzYx9xIXIX6SlEBT0rqi54xftG9xfQYU6qCI5lF6jKwTOonSyZICulEi6mLh3
 Yzd34Br/qYkNDF3ONTa8HPbQb3kh1XaI51jpwENe9I4et5SAVfPutc244LzpGTUOtgvX
 tKwZHVkt+yi5UoHJcyCxWT/qhtejVUWwJruZZWuIpxh8NKbE74IzaJuU2uHarKjDbGqD
 P6/1Hru9hj8xhwdYB/8yW/D+ikJC4tpHps3LiZHgavRBOaZ2IzIdrXYJBXHmfql51qp3
 pmrZklViLqaBlHZq+e5MZ68w1zrhpO+lIK8bxl7TD6gkOLvIM2Csm9K1khX0NbVe8qWX
 q5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103117; x=1787707917;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2htJV3Qn9nRSsGNPzVxPWrsaM+ncItU2iqHptaT2vP4=;
 b=joNTpLcoe1QBfIdoYrYwoKYANtwKT7Trdk4xxZ7F6hkSFaPz8PNRndM3jg3K2uWlik
 7d5r1K0a1krl6pF4PyvxmWEZWJb9LM1VrX6+Iih0ZI/0AjJM933y36HYeViv+3oyAths
 x0yYNK/qtGXPFoA7eQ8835OBF0ENDK++VM/MDYc32z8N228A/pUdJeTLdyXfNU/Fbi5R
 rE10wmoyRYmJLswpyFdWQ9E7O4SR2Z8tIv4wGEXef7iFxQOObSRKjkG3Nr1YaKrGDZY3
 VOC7UUHl3umyCAkF9Lu05VI/CsKIs2IUKfU9FmYbiR9eVKhxmAUccmTyJjQ3+gUmC7dI
 9Slw==
X-Gm-Message-State: AOJu0YzplTEdK0RFCwJcdB3kEExeKL5eSObWxe7huODRkMytRSFpp1Uo
 9ZwvsMk0MQAweiBvr6Es345Wojmg09wTGzTWrLo9QdbU9YiVYCs2/IVtOnLi2DHPYwp1fbwrhIi
 YIbzj0VP+Ootrz4d+ahXAgDEbesOkltt97U2oOGUVmn4pRZeyQGOKcg8pfTUQL6FhRw==
X-Gm-Gg: AR+sD12yaehP6T+0v7naHjItgdJlpM+W85FOvXrR0Xi19EjWN36diefsR8PSBbAQVF1
 Kpcga+/kpfS4rNYhOT4Me+WTdKdUezAjPzoO0tL0GCm4IWkPa0B1AfLrsx69Wo/eEY7Kajjkp5u
 RwAwAJOq1qYwzVH43eELbvpVNv0MnSg5n4Iesk/gkcsujGVQHuSDwQP+mk6NKGCLi2Hot9h+25U
 MSjdeWhJ2L5v4+1T9cBX6GFiM0jF2Kl+s+VHUyk8xWkSY0vidrDAzFF69Cnt5hKxcunFNOrCtAy
 JoO9flYBg6MxgAU3pErrfcJxachZZ5IFBFpPa7OrbdNL9EG9Kbr/wkZLvy81KqsiKDyWnK0oHAJ
 z+Bxpvlt1aQyDHXBpBzKBEJ7W2xhLPU7DryOiAn9RhkjLTF7E
X-Received: by 2002:a17:90b:2c8f:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-39580f119d1mr1990874a91.8.1787103116714; 
 Tue, 18 Aug 2026 18:31:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2c8f:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-39580f119d1mr1990810a91.8.1787103116242; 
 Tue, 18 Aug 2026 18:31:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:31:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/11] target/hexagon: gate GPCYCLE guest register reads on
 SSR:CE
Date: Tue, 18 Aug 2026 18:31:39 -0700
Message-Id: <20260819013144.3264096-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5I3Szep4mb0sjNzZYm2DlloMOS0djx-R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfXyKmyHP89sU06
 +HfgK86Zno4yD9gLmzDdf3hgdUQS+7uJvKjO6urVsbukr8dLIrcZ5Z3UXRHThSyKLy0qkaJOC9l
 aJdC23Z4cCc7gVUVB+FwnNXsx0kHxWaQka77D678dA2FcUZ6FIFMof97jlH+7AFqqLEDuwuHwRn
 toyfSveOOP9rYSzYcqJYuA6OeolBMcLxOSQdwsX+51IucVlJsvGk973fYKYZB+FvYNsi7K7Y0/J
 to7+VwkP3MsNcmTvOeyBxqMk5o1FI81Xy6yXqOUvRvMkRyP8pLy5AB1NEFslad+tQ0WfinuCBTE
 0ooepVxK4YACsIvPN7kmw/EXm+odlpdL8mSYmq/MQrYG5tPqTblpCiIirh9C+DZzDl974osreha
 /I337RC6ocQeZa0mLsikNnKKHZW25c5O+y/yct4GOosFEVS7k+YqV7jUy9fwdswGnRLDRrm/vuM
 0LveOeGap5R7a3K7c8A==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85078d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=t0ND8AI8szmjwSGyRvoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 5I3Szep4mb0sjNzZYm2DlloMOS0djx-R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX90II6zAsh0gk
 +pythej6heusnDlxokW8nUmoxG95hVzSl0rD9P92hUsJbttNzd7ZKNpK0Bawi9QeIwfF1UPwbrm
 OY3NU5T6YvIlUsr8tvs+uR3w0VIWh0s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
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

R1BDWUNMRUxPL0dQQ1lDTEVISSByZWFkIGFzIHplcm8gdW5sZXNzIHRoZSBjeWNsZSBjb3VudGVy
IGlzIGVuYWJsZWQKKFNTUjpDRSksIG1hdGNoaW5nIHRoZSBoYXJkd2FyZS4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9jcHUuYyAgICAgICB8IDcgKysrKystLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgfCA5ICsrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4
YWdvbi9jcHUuYwppbmRleCAwYmJlZmMyZmI4Ny4uMGE2Nzc4NDBiY2IgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC04MDksMTQg
KzgwOSwxNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNz
ICpjLCBjb25zdCB2b2lkICpkYXRhKQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCiB1aW50MzJf
dCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQog
eworICAgIHVpbnQzMl90IHNzciA9IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl07CisgICAgaW50
IHNzcl9jZSA9IEdFVF9TU1JfRklFTEQoU1NSX0NFLCBzc3IpOworCiAgICAgaWYgKHJlZyA8PSBI
RVhfR1JFR19HMykgewogICAgICAgICByZXR1cm4gZW52LT5ncmVnW3JlZ107CiAgICAgfQogICAg
IHN3aXRjaCAocmVnKSB7CiAgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86Ci0gICAgICAgIHJl
dHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhlbnYpOworICAgICAgICByZXR1
cm4gc3NyX2NlID8gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coZW52KSA6IDA7CiAg
ICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFSEk6Ci0gICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50X2hpZ2goZW52KTsKKyAgICAgICAgcmV0dXJuIHNzcl9jZSA/IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChlbnYpIDogMDsKICAgICBkZWZhdWx0OgogICAg
ICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgInJlYWRpbmcgZ3JlZyAlIiBQUklkMzIKICAg
ICAgICAgICAgICAgICAiIG5vdCB5ZXQgc3VwcG9ydGVkLlxuIiwgcmVnKTsKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMK
aW5kZXggMjM4OTRmZjNkMjguLjJjZWExOTI3MjYzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTkxMiwx
MyArMTkxMiw4IEBAIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpcikoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHVpbnQzMl90IHJlZykKICAgICAgICAgcmV0dXJuICh1aW50NjRfdCkoZW52LT5n
cmVnW3JlZ10pIHwKICAgICAgICAgICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdyZWdbcmVnICsg
MV0pKSA8PCAzMik7CiAgICAgfQotICAgIHN3aXRjaCAocmVnKSB7Ci0gICAgY2FzZSBIRVhfR1JF
R19HUENZQ0xFTE86Ci0gICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7Ci0gICAgZGVmYXVsdDoKLSAgICAgICAgcmV0dXJuICh1aW50NjRfdCloZXhhZ29uX2dy
ZWdfcmVhZChlbnYsIHJlZykgfAotICAgICAgICAgICAgICAgKCh1aW50NjRfdCkoaGV4YWdvbl9n
cmVnX3JlYWQoZW52LCByZWcgKyAxKSkgPDwgMzIpOwotICAgIH0KKyAgICByZXR1cm4gKHVpbnQ2
NF90KWhleGFnb25fZ3JlZ19yZWFkKGVudiwgcmVnKSB8CisgICAgICAgICAgICgodWludDY0X3Qp
KGhleGFnb25fZ3JlZ19yZWFkKGVudiwgcmVnICsgMSkpIDw8IDMyKTsKIH0KIAogLyoKLS0gCjIu
MzQuMQoK

