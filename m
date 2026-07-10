Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BB7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJjm-0008J2-1I; Fri, 10 Jul 2026 18:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJjd-00089S-QI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:30:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJjY-0000YN-IK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:30:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDcdv1811763
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EWQ3LJ8VFJ+WvLlyHSspiIiFz2M9arEE/A9vNqvSo3M=; b=noqffdjEyDCXO+Hl
 LFZtXcu8835Qgh8mMpjedRGoFEr8CTS97LL+eE4N5F/zxX389HPxoftesofAVvaF
 jn7ZMdlem1h2m2g2Q+eClc10xq+++FWLzlBFqqD6JumnFAV2KuvEQrjnHtWl48f2
 OKPy36dv6tlVBUMZjg2+l7QNSzKOo9WiZT49K3HWIYmp+Zm33SLF+JQiVJShsFY+
 U4YCGhyV3Ir8oiCK8Yp6L/RU6oEGXnFQvaNfgz2fTTuezgWyH7ZC0TbC5WgGDaAf
 l/JaeRiwpiBzF3fWVx+IXXie71B8aaEmaWdM5BuizV8JXbSMa2yEd3Dd15IOGXaF
 gvDX2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fanh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:30:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so28413711cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722611; x=1784327411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EWQ3LJ8VFJ+WvLlyHSspiIiFz2M9arEE/A9vNqvSo3M=;
 b=Bv5cpGr5imeoLMulu0TszOcUj5fHbVXjSs4wsjtMCktJEa1HfFMGsb3SJn3wIWoAhX
 WUoL82yPIqb7SwhGyIyk8XmQsxv2RJXv2jKbj5aQMA3G4gVRWdZx+SfiPRUGAvppMn3v
 9EllePZLUIN552RgdXXU847FjvOK9CXaukORK0lBxWDxzcZVswhMkqF3aTJpEKfPZfdM
 yYHj67m2EtpQebgiUaMfagw2N0PUITyVXMEs44Ytr+zylhgkKfCIxTXlHq2kb1LYmj4m
 9niTIlUFcdeh47y9w5oAvhRR1ZTbCGhEpHgQWwB6+89pdeV8iBWr/iYImutRMAf+AzlP
 JoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722611; x=1784327411;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EWQ3LJ8VFJ+WvLlyHSspiIiFz2M9arEE/A9vNqvSo3M=;
 b=YMyiY9j++6DLO5whEKk9rQ9gjew0ExwZIxS6poMcKyyFNJFAlaaXR8qt1RTqBDINI5
 AebZuyryZgccwqO8PRkTd0CNwg0WbMV8bKIt3jTutE2i2pmf5mgSrZlkckfLL1qkL2i1
 WANYMGYjeErpopDIcIMuvWApBlaEDmIwbTt00EXmMmSaz/7fEr0Nq6qezySjMQ6Zedhc
 lBzMIS5by4HKXlJ3cfOaHZH0eg0xDT0y6jptJ38jBVtDef0tyjhRXrg0wbSttm+32eaO
 10ZDuwksFp8eUxLzqaYeJ5Q7b4+qXOTwcEMU1JOjTQSRKpyKHZcsqEtnRmdX2dg5BA+4
 cz+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvtobyWYdRMaBvnevkDs5LvN6/PG1m32YAWsY6TazQjfKu4uMd5Mnbs0AoowiNlXraPfT8EMZ1xLoR@nongnu.org
X-Gm-Message-State: AOJu0Yzi/ZXlnjWswN8z+4NPLVHB7g6W0+ZnQMkd3/LcUCPMOhyHio8l
 9WVHIN0hP+atf3yVUTklCxysSgfR/x7GUNbCxih/N/ygfgUDhJzRr8b5jV1SLIwU4U1x1Ne34WC
 +AOS0ovgg2AQbpFAhOuzld94jvHAAzyTLO4L9FsqyZ5QIEyHqT8pnbuWaTw==
X-Gm-Gg: AfdE7ckd1ntKyIKBcjQ0RNHeukrukIDEshNBc4C9So1AAY+2pYAIH5zmKQBNkSl2OTL
 Aw+2YLwmK/saJ4kV3vGzecI49nGmc2+srAPHYAvI+CifLV7+1eVhk6xF6VHvJ+vIuw6n7VC/Vy1
 7d+FdyrMWbRPxm7fA2gJmUYpD0uqrd4rikTpPzlJkwKD/u9ddcsfyjkT60pLiWtJhhr2UOV9NoT
 IKkIRvF1TouBzLZkW8C1wOU+Rbx9szdYL6tCPEbIzx0JWNGH1GQ4fqMhF8iKwQsSczuy1f00/Q/
 +O9RSGOMIM8x1PXazEQckjGvtBVc5h3d6rOgboqGKHVxynlx6NUFMVrsHSaZE3vDdh9uHUvbf3b
 senM4P59heUiGKj219CixtzfA0Hov1AsYB4eOF7TSAWZslmnRORxNpoVdB02NMg==
X-Received: by 2002:ac8:7d0e:0:b0:51c:7b12:5fd5 with SMTP id
 d75a77b69052e-51cbf349147mr8988311cf.81.1783722610833; 
 Fri, 10 Jul 2026 15:30:10 -0700 (PDT)
X-Received: by 2002:ac8:7d0e:0:b0:51c:7b12:5fd5 with SMTP id
 d75a77b69052e-51cbf349147mr8987931cf.81.1783722610457; 
 Fri, 10 Jul 2026 15:30:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f86556acsm13634475e9.1.2026.07.10.15.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:30:09 -0700 (PDT)
Message-ID: <aecb5a12-1e3b-4cc0-81dc-1fba2a3b540b@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 65/98] tests/tcg/mips64el: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-66-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-66-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a517273 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WEpSHp9YiHGgXMObp_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: zy0fT-xeP7UUdI_eunO8CXsEzK45VI9X
X-Proofpoint-GUID: zy0fT-xeP7UUdI_eunO8CXsEzK45VI9X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX9z15wcd6lKQa
 Jg/6LTfJUbNjMGlC3mB5rblwfGuLgkWWlCjU6pI4Dc53O9a3ZI+oNFrK2zH6afeAfwL2nszN0rp
 L6ra00N2uA7nrloUTa6NPQJngs95cIE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX2aSSdOFcIoaa
 oFaDm5xP4yPWa9OP8+RvS2G+I1Xh05v/cnQ8mhpW24y0FQGf5nrIoDJKfyvoyFeKtoyXSpOdyCu
 1jeLfsccZQuKsJWRGC9k4I0S5JSRijfhB2UhZFl2Bzadw5n8YdkPdlIDM0ClNppA7BZmet0aqbJ
 AkcFJxwX2xKeJQJ0iWxBrHqK1LHfFCp/QbXyFd4ExYnlQ5otm6sosOTBKPrw+6UymYJc997o1oQ
 guXHqWt76suP+ftAAITcu0tx+RV0Qjyjdo3T0uLgTJsCF39LRA2WfvQ9J/Dt4gfwc/udcEGjOAJ
 vV29bdw+1yggR7OGKGNbLforVCPGVWSdm/BrVuk3EDeQNneeA2gU63XqlbJuSenn+2dTMi/mu5e
 BOysjoi/AWMubP0e4MNsObWZTzMG/M11fGtDBXScVg1cuHuTw+RIASViO1dmc89uZow3Q903Shz
 ZGKK6ika9kDffB+w+BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100225
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build              |  1 +
>   tests/tcg/mips64el/Makefile.target |  8 --------
>   tests/tcg/mips64el/meson.build     | 14 ++++++++++++++
>   3 files changed, 15 insertions(+), 8 deletions(-)
>   delete mode 100644 tests/tcg/mips64el/Makefile.target
>   create mode 100644 tests/tcg/mips64el/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

