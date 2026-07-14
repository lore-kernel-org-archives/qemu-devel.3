Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E1C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfCE-0008VI-NB; Tue, 14 Jul 2026 11:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfCC-0008V4-Tv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:37:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfCB-0006sn-EQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:37:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcWOY674502
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6DvHdtxruWPzogbQECRgm2uZ/hauKtiuM4w5wcef7zY=; b=XWZOUB9wldSJUeDD
 +xTNXHlUBJk/i+OJ6eCkDkiOlC4N0wHCnNsN1QCyAAvVYKEotmuE6OGO64W01nMs
 bvGymluXbyobCh26Hf9LgcYyKEsxSz9KeTSdgxIOEQY4YINjSV49ec5CKD99nVx5
 1pZHKJLf3oKRR05KwgRMs70jIhmLLHdAQtLE66HyxxO/HyR1QhgeBSw+ZtNiP6+6
 +lgltch0Cw4FWlk/r1r87McGDRFGaJDMhiqeqFIup7znRY+cihOKEXc33UF+ih8k
 +zQSYf0OkelaTWTnpGpEzqISldXGnE/Igw6/oh7o6K8wwCoCfJ1n+8u7btDKkXkV
 u3tIiw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnp0gp42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:37:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c894391f000so2456854a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784043437; x=1784648237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DvHdtxruWPzogbQECRgm2uZ/hauKtiuM4w5wcef7zY=;
 b=IzdCXycBAQY48Wo53nEvVN2GutlVOnd4S5d4BrBjJGbd9DWCpqBBBrRHJMX+AZQ44q
 pz/MaJD+l61c7tdqPhYc8qDoYyeIfPT8qRG64er6bA2Y2PdDmoKlIO0EEEA+U8yn+LA2
 UKtqJ+ZLbQHkR3G76iz73DlI+jXhm/A0oYxK1tEJASjr5stOaExjFBANXvYfDY63UARC
 /1yagMr+h/U2PqZ9y1jOWXSWkW1RjF+yxNskK6a/YUmmQxX/8MqRSqKEejfNxyXEjbGR
 fisN4tfI/3I+Wy+HO+4Z74zSalHSPPLobMs2JpQ0KrrmEOVDxSGWvTvVgGzGDwexYrAg
 eykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784043437; x=1784648237;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DvHdtxruWPzogbQECRgm2uZ/hauKtiuM4w5wcef7zY=;
 b=ETbrZRcY5pj+GjmGsWaj3gRvDLxUD44noVdNbYh0vOk7DPUvAFw+LvhSUwEWHXY4v1
 qjfUuZ8aI4wgoad5+B7/PS22kMYFWFNGkdj0BjLlToUoF3iy22QblJIPE6kxwOCb2DWQ
 mWIGMegUVp8uWtBRI/EbcEgJIleWz+oR7FDlxBJ4tQReHvzFh4WMnFRVvhUaIqibzP3m
 yYJI0IC2GOevZdN3LhOLjZAko76TbN+sHASbji6/f7YSzRj5opcc9ARE8XDTRuDfIY5b
 WeKupK8g+Decq0IHg5gUBLtHOoXJYOXlNDzhT6XY84bG7b0BlWgFfc+EZyMHbfb4HwFP
 4/Dw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrH7hi6NssA0l3CXiBHQ9FXF4+40DkU6Rq+3yUXMmL3e+hPQZY9G/u4IxmW+crJxGpUgSjmUFfV0+WX@nongnu.org
X-Gm-Message-State: AOJu0YzvDJtvwej6/UbSwZYQhL1UWnQ9QhVeoEbZz7IR4pS8Jawr3NhC
 I/8hifmM+HCnX6LNPR7KbXhu2KzD1N6rGODZtRKWlyCE/o6hGp1HWRaRmHaWD6e2MhhJ1LpIBa6
 oq9YkG7xorPDUsAvNW/oLI0/VnxeOyh0ICjdbJ7C12criIgBY5wRBfv98Bw==
X-Gm-Gg: AfdE7ckmqjogTPMQALgkxVpdApc9ZTvd12r0ZAfvnyLDGr4FeJrIF7c5byaQD/BV25H
 eFJUWvavhlhKvzZNwfNZx4w7iXAyDPGMITQvRS4VeB2/qmSNe3AebD/MbWFbVR36jCVkVOfQYaV
 DAZljZChILppBSiNWiZhlHIo1qhDYPSozTWPZ4/rk0IVHz6oGF5WSgdM4mKn2+ebJUekJmnbhTe
 AZTrY8ewoSFJkrkYWCxK97AS9AOKrMMQBVO+0wp2GQhv3xAb9M+mxlWiNjxEWJ+gj4FHTeM6X+l
 Gvhyg5X+3HOI1DHlroG3p9XYIAwDp0yQOYlYZWzplxSN6Udnhr0Xd9WOqlkkLLHPJPR9ugorj3C
 7dPB49oWdvTGeAeIxz4T8euVBqxQKJ4IJQNoUBGdE5KNWlG+fbEcqLwyp8/zKmZQqGAIa7x5XlW
 LTROs=
X-Received: by 2002:a05:6a21:4591:b0:3bf:6c08:2841 with SMTP id
 adf61e73a8af0-3c110775a5bmr15217653637.48.1784043437041; 
 Tue, 14 Jul 2026 08:37:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:4591:b0:3bf:6c08:2841 with SMTP id
 adf61e73a8af0-3c110775a5bmr15217629637.48.1784043436608; 
 Tue, 14 Jul 2026 08:37:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b84d6ce15sm39702663c88.5.2026.07.14.08.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 08:37:16 -0700 (PDT)
Message-ID: <e29c4eaf-b429-4566-a598-9cc18a8d1cee@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 08:37:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 81/98] tests/tcg/s390x: add float reference files
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-82-pierrick.bouvier@oss.qualcomm.com>
 <6738c88e-235f-4912-84a0-fe3acfe50c06@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6738c88e-235f-4912-84a0-fe3acfe50c06@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2MiBTYWx0ZWRfX3hXE90Rl0Jlz
 31oPmwV/2GAcC0oh/Ann6eynYyAcsC9BWlDchxBEjf4FEa3wYKUbvWhNE5Yh84K9iUaoWiwvI6J
 ALZshqqJhZDNil81xXnNLnNk8lq1lM4=
X-Proofpoint-GUID: -mRQhkFZDG0T1_maVM1EZgUwjahgBIoB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2MiBTYWx0ZWRfX40QxRMUepucL
 Znl4JhvvEuAI4FA4tjKOuGdaYPv3/kRW+uIr2xF4rmTRu30sNBY9l0QCVsbVJM74Cfdh5+tu0AP
 KLTnI/5tk/MlKIRKATp1eVE0pveCiJa4moFozIy1oI141ui0LjshxZsB6RC+u66wxCKjd7lQ/iC
 MPofS579WxtchqU5pzvqt/94EUiFxa8X44hTdEkO4VR5Pt86cnZlWnNbxs5ojAn+FInKULnlCTH
 jd6vWSBiSd3w93bBnyadkgqsw+q/UHYkLB/icdrpTzpMdtKk5mdMBKwBFBjcKtjQ6mm8HWtyFHq
 4iJqcTv/GPW9ieeZgMAL32QWLmnvBI4/U5jesmlsefMy/5CXjPu22Y/SJyeX1bSEfutx4h5MoIc
 4HXINIltUeHrMreR8FCOA5r6NOkdjU0dtLTzLpYJCXDNNVQY24orrbKnp3GbZTbnPaHlo++G3WT
 4nJyi9ta0FuTtl3nXEQ==
X-Authority-Analysis: v=2.4 cv=FtM1OWrq c=1 sm=1 tr=0 ts=6a5657ad cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=eL9xj-S0sqmU-GMOW3oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -mRQhkFZDG0T1_maVM1EZgUwjahgBIoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140162
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/14/2026 3:47 AM, Ilya Leoshkevich wrote:
> 
> 
> On 7/10/26 23:43, Pierrick Bouvier wrote:
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/s390x/float_convd.ref | 988 ++++++++++++++++++++++++++++++++
>>   tests/tcg/s390x/float_convs.ref | 748 ++++++++++++++++++++++++
>>   tests/tcg/s390x/float_madds.ref | 768 +++++++++++++++++++++++++
>>   3 files changed, 2504 insertions(+)
>>   create mode 100644 tests/tcg/s390x/float_convd.ref
>>   create mode 100644 tests/tcg/s390x/float_convs.ref
>>   create mode 100644 tests/tcg/s390x/float_madds.ref
> Would it be possible to add an explanation to the commit message why
> this is needed now and wasn't needed before?

Before the series, we had only some arch that had those files. I have no
clue why to be very honest, out of "people forgot to add them".

Makefiles were "smart" and skipped the output compare when such files
were not available. This results in arch being very inconsistent with
some providing all files, some providing no files, and some providing
some files. There was even one case of a misnamed file that result in a
skipped check.

For consistency, the current series adds all missing reference files for
all arch, and make their presence mandatory.

Does it look like a good reason to you?

Regards,
Pierrick

