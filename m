Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A030CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESgE-0003v0-Pr; Wed, 07 Oct 2026 10:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESfe-0003Zl-Of
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:31:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESfc-0000tb-Ba
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:31:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVLm64178599
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B/n/0Xwnp0s33NZUQXvH5NVlOV02EeGpTS73m+LOoSU=; b=O023j997wFJ6cCpz
 gGopL4JN+IMfKHYdZylvOUEHki7/m3uLQ+D2WVF789EPERH68V7TzmLEUMg/3ccT
 C7OuIwsNVllubo0D5at03H9aUCpcDuaXxOT/mR0YZ3k1483qum0JqgDYWQ/Pgmmm
 XVe/5nK+6vFR4jijMOq6vS6wzVD9sB+Nfvt16OPwlWD47EdmHV9IrY0WCWkgSYmM
 /4nX+/3nGRtn1XayOO0P8MQ8GzO1Xzi+emVG748CgLFUmRkS6f5EYEDgTXVzaeDz
 gryvPN25IdFfTEQZixUJ1hiyfPcxf1nrVp8Z2+LzpwOg03rIdvM3MvmatSyVYG8q
 4uI4Nw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c60ake3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:30:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so1496838c88.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791383458; x=1791988258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B/n/0Xwnp0s33NZUQXvH5NVlOV02EeGpTS73m+LOoSU=;
 b=chZ5iwuJl+Fiuf6uTK1eXFZbbLmpy0FTzmIRL8uJ9HXt9lQRt+uwoZfoBRXmUIl2HQ
 cccW2EpCZfHC/KyaW2PN3SUGLyClphwhoFExcve2YVKMe/BCVsOBVFZDO9tF993ao0mJ
 GUWej5UFzqa3429j49W+FxRquI5fYR/ILWLdISoClVl7NdUGZpueiqbMFWmVyNXgBxKh
 eZpGieP3qhfrCuwfgQ98ifl3fSOviaF2EtBodj8Dr8M8FUzO9VvIXFg9r8RRFcvx2gku
 /9dbaRBCdr83iqWQC1BLM8gM2uTZlw5PzIX0h+EXZR6DA3zy2yh61ooHCU9oyNV4RKVx
 QdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383458; x=1791988258;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B/n/0Xwnp0s33NZUQXvH5NVlOV02EeGpTS73m+LOoSU=;
 b=FPRW8ShyRbgDD1BZaAUyyuVRrPtY8hTVSuSB++ukLR95wv0NQB/JJzU/Si0IntWS0s
 GIRJa3mgQn1XRrbyUWBGvVb2sNjTPTuxnt+zgeFuY4z4PiMWNXJaZWqhtCfQT47wmpM2
 29aW02KqsUWg7GZOmZ9aUeBKQtyFGH0B6v9jxmsQHPwBYiE5jVwU4NNVtrghRQ2QA17c
 DD/dDusXp5GRt4r8Vp2ZNNBE3Y0CUvC1uzuuVRm42IczK8SfVOG6N+S4yhs9X/OsYafN
 DDJXt8A3FggFJhnyWG1rlrSj/NqN9uZXCVEb/cMn8vXxstaGtxWRimhfPGi0fq+SsVCd
 e9jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQzeWaBQxc6SXxj3m6iLqJgUIy9SghEiJyu4FaEfOAXqYIzNfsbfPTa66CFDdrFlpzvl9ZiO6VZdEP@nongnu.org
X-Gm-Message-State: AFuF++mvD1bBy/fOC0eQ4u3s8r1Rtl4qrphdW5dxrskXaDa7PMz5uDPK
 3brJsHS2v6BfVdqTj6XYdvxauXO0HK7Pi+x+j2eagbwPr+o3uCjXD813rHgcA3LRNl13cSNLr55
 MukN6aJqLY9psnUj/baUCMklFZKG7jqUlTuZFGtogPx+tfFtyzGTZqHejnA==
X-Gm-Gg: AYBFou15mKI5FB9iCOV2zq2dad1uAkPPEShjkqz+BZUQofkfjvosaReAFjRZn782Vkj
 QVGzVBvmcIWNhzKt9OjL4kKBXlVuhoyySmVIo1MY3wiKWwKJdPTalsN7Vj5t42w35ESBD8hENDh
 JK2q+S3ENIVBgyiUvsR62eMlWUmR15UzctOufPpVgEVig6z0xBjlr0u4GbQusrygEZJi90lvPkt
 s0deW4eDR+wBH2cmOhNZjsgc+q6623ypl7mqx3dUpLkfHgwn/Z79Eksy0qtnVaBAwK9KdXrEQUm
 yXmEA0TTNZ/jZFiV58wF6URpKhUjFqT18gI4szhUo09siqsl8gGKVkolvT2A4zyZH2kocHpsqyM
 9X/OMeaObt91y0ONxBWuxo9oU8O7bZ9i+VCGpqtAw3Ox4Zesmwba2Udp4dwRRcKnhtR1pWg==
X-Received: by 2002:a05:7022:4a:b0:143:50a0:56be with SMTP id
 a92af1059eb24-16204a8206cmr3211604c88.14.1791383457630; 
 Wed, 07 Oct 2026 07:30:57 -0700 (PDT)
X-Received: by 2002:a05:7022:4a:b0:143:50a0:56be with SMTP id
 a92af1059eb24-16204a8206cmr3209457c88.14.1791383440659; 
 Wed, 07 Oct 2026 07:30:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1616980c3b7sm6678694c88.16.2026.10.07.07.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:30:40 -0700 (PDT)
Message-ID: <089680d2-ff05-483f-a121-86752fe66a8a@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:30:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
 <95c99cac-ae83-4bd2-ab09-51c2ef9f1259@oss.qualcomm.com>
 <CAE2XoE8fU_dkJ+SgUoRoS0F9=OJL3P0+x4-E2aOTcYbda9uaPw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8fU_dkJ+SgUoRoS0F9=OJL3P0+x4-E2aOTcYbda9uaPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -jH4kZlL-PPlIs8zerDGkGIeorQ3q75h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfXyeF9f9R3Gyao
 VBqbxcPvcFDr8Vd8Xw27aQZYQoMpKmKSfvjtmr7H7m6kcB6LTEc2pvF3ktbwNBH0eky3w3qCfs+
 cAclLxy3u3VRpT7pIqN6Rzkc0ymwdB0=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac657a2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=n07Qmk2SgEuCUtPOkRwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: -jH4kZlL-PPlIs8zerDGkGIeorQ3q75h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX3gW1OVEftrqU
 OTtirG489jQXmZl3OBaMo6dacxgGUC4KjVuETMq6mARG4gtDoyCGGAjAp736yj6SJZSpNmiDv25
 TU0i438nut4AglplKMt+9b5WMI71S/paNvsogmP23dPfrn368b8ZrUZZrgaHt4zqKnHSbfhCHhv
 YQ3Zb2amVD89JH+TLgz4qkZ7Vb+lCuxLKU3Z9KiS0j5HmTqaIxmMaUUhy9GVY3PKK4SzZ4Dil87
 j8GfdrRx8VfxKtXzgezyCpO6gR3fSr0TrW/7k1ZchU90IZ1LUkNbjGn5BUDcE5XpR4fwg2UOqiJ
 Gm/WZQRfF7PLt29mdBb2tNTH5lxFC8egoBpPCl0UtTBiv2Ip8ZqaCln4VtWKlqnOCINY3sQl0eo
 NDnTUf1dLwUDddvT2glmxoAOnTVTFNe9SzoQ2jVf8RVWC6Po8FF+qLMx7/Ozb1JD6ZYgR0eFf0c
 eUvIYoOVTC1SE11lfsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

On 10/7/2026 1:28 AM, Yonggang Luo wrote:
> On Wed, Oct 7, 2026 at 3:42 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 6/10/26 15:56, Daniel P. Berrangé wrote:
>>
>>> Current git master is exhibiting a regression compared to previous
>>> releases.
>>>
>>> For example on 10.1.0:
>>>
>>> $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
>>
>>> /usr/bin/qemu-system-xtensa: "xtensa"
>>> /usr/bin/qemu-system-xtensaeb: "xtensaeb"
>>>
>>>
>>> but on git master:
>>>
>>> $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
>>
>>
>>> ./build/qemu-system-xtensa: "xtensa"
>>> ./build/qemu-system-xtensaeb: "xtensa"
>>
>>> so we need to fix that behaviour change for query-target.
>> On a side note it would be helpful to have such test in CI :)
> 
> I have already done that in
> https://patchew.org/QEMU/20261004072927.1142-1-luoyonggang@gmail.com/20261004072927.1142-4-luoyonggang@gmail.com/
> 
> Check that query-target reports the target identity selected by the qtest
> binary, including softmmu variants.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/qtest/qmp-test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
> index 927ab053f8..c70f6a681c 100644
> --- a/tests/qtest/qmp-test.c
> +++ b/tests/qtest/qmp-test.c
> @@ -164,6 +164,18 @@ static void test_qmp_protocol(void)
>      qtest_quit(qts);
>  }
> 
> +static void test_query_target(void)
> +{
> +    QTestState *qts = qtest_init(common_args);
> +    QDict *target;
> +
> +    target = qtest_qmp_assert_success_ref(qts,
> +                                          "{ 'execute': 'query-target' }");
> +    g_assert_cmpstr(qdict_get_try_str(target, "arch"), ==, qtest_get_arch());
> +    qobject_unref(target);
> +    qtest_quit(qts);
> +}
> +
>  #ifndef _WIN32
> 
>  /* Out-of-band tests */
> @@ -517,6 +529,7 @@ int main(int argc, char *argv[])
>      g_test_init(&argc, &argv, NULL);
> 
>      qtest_add_func("qmp/protocol", test_qmp_protocol);
> +    qtest_add_func("qmp/query-target", test_query_target);
>  #ifndef _WIN32
>      /* This case calls mkfifo() which does not exist on win32 */
>      qtest_add_func("qmp/oob", test_qmp_oob);

I'll take it in addition to the series I sent. I'll also add a from
"you", since you posted this first. Thanks for your series, it really
helped us to move forward on this.

Regards,
Pierrick

