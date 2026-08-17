Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D764C5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoSD-0000Mx-In; Sun, 16 Aug 2026 23:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoSC-0000Mn-6Q
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:56:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoSA-000836-JR
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:56:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDPkJ1386433
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sWTh85D6ak6xvrewhD+vgkHDTt4RU/C0Oz1B/WMmm/o=; b=T8CWutJlCiApbq3j
 JaDYY5KV8yUwf+0OgnXqCYUeKiZdYI18VBYcPM1fbWlgTKVmTEdBK7vmubmrU78x
 5J3C/PpMxkHbXlS6GPb3G8j/BE27Hmuoy9beKXPws8k1SILcUPs3d8XcOOJjD+NL
 fHy2qeQScfYAkKG3OmTSJARrKMz0Ooivs5C8bAoudzaIwr+FExrB1uj/SILsaXGF
 npM+bdE/+Sh7riLbvMG4WEHcZFPTXFhCEQiebaOHiIFZAm4dAaYU9x0/VvAmcQgo
 aglMgtx80u4J3TQuCIq/wOCuf/z1GoVLkVK8pVRLHkFms81ypoFnwotwFVeuqxzg
 +vNFOA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3mx4rqf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:56:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e63df032bso375180085a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 20:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786938960; x=1787543760; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sWTh85D6ak6xvrewhD+vgkHDTt4RU/C0Oz1B/WMmm/o=;
 b=ZEg15R2omuJGN31fwzU7TV1l0EwQ3rZgC2OQ+DCXAUHASWwEVngqQwka9zIM0DjSll
 Oe55Kn8xofNkGClLigAyMZu03/I0WX3R8KbVDTrr31GqzWluBnh+UyVvclaWGdrHCk93
 5zWui6Q+1jq1fsHJiXBs3LitAOtjMfduxU3GfniR+eGMUiUIG4bHYQbldbQ07LmwXQ9K
 yecCMky2Vnr4/I+5yu83DmOP38eXweP64wZLQ5bDyAd1Bqut7l4q/VZlGRz1L3AFbVFM
 yAyE/DVtsZ0wva8Soyed6/WQ0iGwlKNOEXWhTa4bYMxIz03vu6PnhOE++32KJg2b1tJy
 METQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786938960; x=1787543760;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sWTh85D6ak6xvrewhD+vgkHDTt4RU/C0Oz1B/WMmm/o=;
 b=H62ghk/x8nhJYU2R0CK18W0XfX49YoxbBIOMEAXDGxl3O7o4tO10CrFK5dz+pCTaHg
 7r/4Pxr6GSmOAQmGPkMUmWloXRwYQkTkzNYMWZsovuJlD0BHxtHBiozukwQhxSmQn69e
 5TYL2PKAx21ca7u8Pno+faRVsYVkMV1ykoZP5Z8HjJBnYl2xJsc5fwPQeV6P2pM3/kbP
 +BD4c+VhlfqPHOZIs3JTA0hDFqVQvOiJWirYjowzD2DafuadO3w0MjwZBwVIUSY32N4N
 un9zJceHetK/VaP2HHZjWKvVGb1eRXme+27GCrtBfw1jvTz/N51alrSktkQXhRitG+Dg
 XA2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Roy6oB6jSc9WiaLxK/PDv8guFSLzoA51haT44Y/Uoc3c4tFQEM39KTKmrgXy8yJ3rQqJMz6uECiSi5B@nongnu.org
X-Gm-Message-State: AOJu0Yw11VWBOtmZrmq7uUOwmg3jLTUksBeLYQD4XvZqX+C/QfvweXZa
 ltaFS3GwcadY/fPfwoFB0RWhUOU+uvS3BmyzJ1hR1cHAFAUTzft/Ci/FMYXmP4yQa0lIh2A08Nf
 Ff1NLDa7tHsdiVoGVU8hVmpbViM3+fDuzsydcHltgHK5+AJ2fNXnPB0NqeQ==
X-Gm-Gg: AR+sD11kaiB7y4zHsf1qXndBAEkRb0P3Z/hr/NZJntwHDBFPrJfA10ddaFFPp8aPqEL
 /Sk87Qbg7sKh8H9IaSKHWJ/a0aF073IFMjMCSlVOp9LKSWsgbhfygZRHQDo3a18wazSEbi2vt8B
 1pwoa2KxI7lHKJC4k5bioHx8YzGL8Fo7DLSh7IHD6Wl4AAymWyoevz8mjIz2qH2PCCSzQqMbJZg
 T3PBCiP4wYTaPc4ZUlESr6MF7FYYZm8dQHRbrK5/qTyIjazkPY2ovUClule0q/cmqU+xWcP7DbL
 JurOuS45Gzj/A8Ibqg4DqcgeVy2KasWrdRXfpsyWHEpFpkl5uQ/DD8rI3lJhI49Ltz52cC4AQ8S
 jdxgk4kxQA2nhZioLs+1tb6/HvwCynqhhOUM=
X-Received: by 2002:a05:620a:4611:b0:915:29cd:306c with SMTP id
 af79cd13be357-936c06436ddmr2729194985a.9.1786938959847; 
 Sun, 16 Aug 2026 20:55:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4611:b0:915:29cd:306c with SMTP id
 af79cd13be357-936c06436ddmr2729192685a.9.1786938959434; 
 Sun, 16 Aug 2026 20:55:59 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100184sm144263445e9.1.2026.08.16.20.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 20:55:58 -0700 (PDT)
Message-ID: <d7121bfe-a2be-45fe-b933-70190e6a369c@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 05:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/49] tests/qtest/qmp-test: don't depend on
 human-monitor-command
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-13-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-13-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gxns_0u90zVcl0KjAiyjeZcTJS5VQZn1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfX0jBV2vW8Rgo/
 vzRXLjGF2Et0r56gY+Fn+YQXkFHOqtyd/NnnLCsgsVqiivicrjbQD//FnNpWO5uuC8TskLjj6GY
 8eMtfiRuRIe9RvFAFnD9SJZ6ZBRBvbE=
X-Proofpoint-GUID: Gxns_0u90zVcl0KjAiyjeZcTJS5VQZn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfX4nECEMnNeYaN
 7b7mXbB2AWag5RK6JHdvuQSNjl+xwm3YRTHthATAtidvaBz7pqVHjvQa4R1lwPJhHuRlPjq5RSR
 +tAIE9+aSkhfZstb2PxZl8tW1QRWoLJNcW/Qmg8KTIQOC5PcJKC+EJKJCcmWN194AD7vrN/PwOx
 i+humMFpeDrpHgMkXAyPfgBZYt1ld2MzPHYb1qYEWI+vqB2dd74s0FJqp+hHNpz3Ch6hoB6h2JG
 ZzLFKvqh9g/ZJ1nrhYLsNyl2ODkgvzr6kFiwOE4wbAAiVJ5hhxK3xc53FgGWn74b20xD1lYOXRm
 6J6uRuGhq536Ydi7JpzoI3mAa0ZuPXGv5Hd9XmQbJbEfxf88ZYKFeB05EX9z0aOlNQH6eQ19Y2Z
 gogaMvaR3gZB5ZP5QtWiqXMZtXt050fbvGS5otVAQMBTcHfUVM+s66INH/yVg67/jwxaQnGNRbU
 hl2zgQ9euMdmeI4nzZg==
X-Authority-Analysis: v=2.4 cv=Y6XIdBeN c=1 sm=1 tr=0 ts=6a828650 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=j8CJH1QEvbzgMSwlvVQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 16/8/26 21:12, Marc-AndrÃ© Lureau wrote:
> The test was using 'human-monitor-command' (which requires HMP) to
> verify that an integer 'id' is echoed back on failure. Replace with
> 'query-name' for the success case and 'block_resize' (missing
> required args) for the failure case, so the test works regardless of
> HMP availability.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/qmp-test.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
> index 3a325a04e07b..927ab053f8ab 100644
> --- a/tests/qtest/qmp-test.c
> +++ b/tests/qtest/qmp-test.c
> @@ -151,9 +151,14 @@ static void test_qmp_protocol(void)
>       g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
>       qobject_unref(resp);
>   
> -    /* Test command failure with 'id' */
> -    resp = qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id': 2 }");
> +    /* Test integer 'id' is echoed back on success */
> +    resp = qtest_qmp(qts, "{ 'execute': 'query-name', 'id': 2 }");
>       g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
> +    qobject_unref(resp);
> +
> +    /* Test integer 'id' is echoed back on failure */
> +    resp = qtest_qmp(qts, "{ 'execute': 'block_resize', 'id': 3 }");
> +    g_assert_cmpint(qdict_get_int(resp, "id"), ==, 3);
>       qmp_expect_error_and_unref(resp, "GenericError");
>   
>       qtest_quit(qts);
> @@ -487,6 +492,7 @@ static void test_qmp_monitor_remove_cli(void)
>       qtest_quit(qts);
>   }
>   
> +#ifdef CONFIG_HMP
>   static void test_qmp_monitor_remove_hmp(void)
>   {
>       QTestState *qts;
> @@ -504,6 +510,7 @@ static void test_qmp_monitor_remove_hmp(void)
>   
>       qtest_quit(qts);
>   }
> +#endif
>   
>   int main(int argc, char *argv[])
>   {
> @@ -521,7 +528,9 @@ int main(int argc, char *argv[])
>       qtest_add_func("qmp/monitor-chardev-in-use",
>                       test_qmp_monitor_chardev_in_use);
>       qtest_add_func("qmp/monitor-remove-cli", test_qmp_monitor_remove_cli);
> +#ifdef CONFIG_HMP
>       qtest_add_func("qmp/monitor-remove-hmp", test_qmp_monitor_remove_hmp);
> +#endif

Should we re-order #26 "build-sys: add 'hmp' option" or add a temporary
#define CONFIG_HMP?

