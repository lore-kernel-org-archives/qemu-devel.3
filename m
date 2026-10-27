Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D51606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aedHgSAk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QFZcEEo4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlAg-0004pm-7t; Tue, 27 Oct 2026 13:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlAb-0004pX-8W
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:41:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlAX-0000CH-4n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:41:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH01XX1284796
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8m4PqkiqwZrA1AZbThc097pJBaCz/hNf1iarLfRqIas=; b=aedHgSAkhDnbdHR6
 DeClQ/0xfoM1clbACl0HCv4y77qlIvoxldjHdcHcL35e1D9ZJxL5+xesZvLSGhlA
 KHtEWgAb2kFLFOE444MDStnxIF/ICLpq4yAxj4/jlwtmMtDVkfRXo3bb54dOJYlN
 hVnjzOeeV1HdEg1SagKaDztEp4pohlRD+a3/kCW7B1aS5EgpLfZWzO6f9cL8vC8U
 s4kQUvL1EdcL3Kg0vu7lTOMatQujHw3x7epHAbAktGQsI0cleZs90N5PmWGpaA2D
 VwpveAgCSxB2xTwvZBtsCm7fjYeAfwzLZWlBQD/uBPAKX2+AXlkq58Gb6pXreJY/
 wV+7Dw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710ebt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:40:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so321094eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793122848; x=1793727648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8m4PqkiqwZrA1AZbThc097pJBaCz/hNf1iarLfRqIas=;
 b=QFZcEEo4iFb/wNNtv7I56U6fPHTnB9cJOZ+1kvO9QXuzvHsgxkYcXD4OLmLxxPlkWS
 NJS6XpQ6Xde9qIOa7N5uHtGV6m2JvaDQpVIzOOf3t3Kvg5tGbaTu4XKJFMf9hjLH7ImX
 hy5utYLJ6MA0itwI5No51UIvPXbd6ubIG+haSCnk1cgPXt6DpRlEbiq9XNLFALUU32yC
 R1xA91i36V+APSZTn8jp0CGqIvjMK3oDqrr8NBh+5ZTbkVIO7hkuxlKZ0JXoUu9dPryO
 ZlhKFhavk2rFVg7jyzzLszuH9b/IZ8THiGpQHmz+2dbxQAtMT8UEHQbvTlVbmSnhogSQ
 6SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793122848; x=1793727648;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8m4PqkiqwZrA1AZbThc097pJBaCz/hNf1iarLfRqIas=;
 b=kJx3R6ElLNOdHPI9CxBfBKifehmVnd2z2CzfcaDSqesj1jG/dKHeWvkucbbYfaNNuN
 5O+AoF5ZpeU77uJOLMa2ATd2c9Ig68cjDIzvKvWJvsQBlK+IyYqRhtShAYGRiTeSkU/3
 E6k5sKqE4OhvbN/Mw5wTsK730horjO9025br6XRN/9zNFW8tyKYDWrXvmZuocX05EHZG
 3F8l7Fv2Vix6WUFKSTND4XORSwvo0y6Y7nioEQvaUNc93KgDY7IEy+lBzreUMKon6MWA
 KRJnkc+FZSjgPwbxYaiN0JocjpFlBO69mNIMZCocHc6kZPh29mn/utrKbB8+htgWbqLh
 fYag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBwJOzyXmjxqh33FZduF37O34sTg8sf9dIZgpXvKC6byAHPbyFNV0XQWiRZhz17djUF0QcatzeVk7R@nongnu.org
X-Gm-Message-State: AFq9FYLfCkkprr5o9e3W/b18p8GKZbW7OjjA9CwR32lKlDJ6CXXftjn2
 +zTjgzb+gkDqDYwqmtC5HPQXKctnrH9bjXiOdWhhDWQCmYJm5/bVBEyjT5Y/LQo0fTArMExzNyn
 zU+LbDAFnUEsmRFwrS9Gx5u4rhLDIblTffSfKLis3bw/Ecxgdi5rJDEH32Q==
X-Gm-Gg: AYBFou2mjypYuYv3u8BBLI3wDwXV/o3usAPEvBCs1jCQ1vjZvro4WnwkxY3BV23yW3z
 6IRV1r9B4vxouKXAAFlqKbigwzKOWabNeCFWRwjfk7Mqc8DJuusJYgEBXIXpgv6DyVq9ROyvaEU
 qJOf9vG3hGq2HDVQVI4OU6QQ7R2aCpLzyjXQB79gxU+BBHE+VwwGmZyfJDkU6hV4aHNzeyUzlR9
 UPcY4QldsffbOkyl9jDQjafyyoRzBD0tZ13oIbqNkVLAlTwM8iTZ6awVHE9Zz3nvtlLcLnNSASH
 Ly7ebzK80E1NjvHD3eWL5V4ei/9cw1TiI1k7xlblb/M115HedwObJuE8jzwBm6aKPW3KgAUDKf+
 2z8MFpaWRU+LeV0i48OPHAebaMpV+0nc0Ft/2zRB56J7VeZQcDCC0MizKJj+q5NaKG3U+7Q==
X-Received: by 2002:a05:7301:6192:10b0:36a:1489:fdf6 with SMTP id
 5a478bee46e88-36a203ac533mr157905eec.11.1793122848172; 
 Tue, 27 Oct 2026 10:40:48 -0700 (PDT)
X-Received: by 2002:a05:7301:6192:10b0:36a:1489:fdf6 with SMTP id
 5a478bee46e88-36a203ac533mr157845eec.11.1793122847492; 
 Tue, 27 Oct 2026 10:40:47 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8afd64fsm40094571eec.0.2026.10.27.10.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 10:40:47 -0700 (PDT)
Message-ID: <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 09:40:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfX92WKBqFxeR17
 eBoeLJ/6llqQi6zK99CvDAda/rTBqRdzTqEIr/Yfxui4t7Hk5x7qEXAOvmZdaGAtav2TLk3yQcz
 PNM+RunalfNM6+JXgM9RLHkHcU+9Ud8NkrFRMzOX1nrOtwRLBhYVBFL7hOn//hl23l5f82VqvrP
 f+gDjjbjiE3D2BN8rJKccyT+lVoYdU+mrX448Yg9MnodkuwoOeRE/XCS4F139tFEzE6JJm4lBcg
 /20tLc7pKh7/ZGg1kezY+s04wZ95Tq0XIOrl++YRn4zjtp1BheUsST+57a/KCgtM5An6YznVziK
 rYyfvYA9F13C/lOg7OGKogrMmG226b7tsKJ8ZqOW+ibmOp6dDdRwcjSlwhTritLkc1kh7nSiYwC
 td33XwyAXKaPtn1cJFqu/esphmtgUHfKbNjJvHfMVVblb1jPt3R/3iMQ5F2M6bV3VbUSuYCK+6M
 rdRMnbi1khgU02XAfPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfXyweH2goRoUDR
 mPhmnEGNOsaibVSLulXOeNr7YW+IZ6eQXFWBZQJly+X6c1KSmkiJ1hAfzrNi+Guas+UrbLrY/fr
 pP63bllOIgm94DZQeKaL88lj+dtT3kA=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0e220 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=BL-dCEGZnT6o060FIJUA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: r_YFV2NaQQUKSPOqh90huTwIoLnj5uAJ
X-Proofpoint-ORIG-GUID: r_YFV2NaQQUKSPOqh90huTwIoLnj5uAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/2026 9:57 PM, Yonggang Luo wrote:
>> I hope that through the recent series sent on multi target topic, you
>> can see better how to try to slice work in smaller pieces. I try to
>> focus on having a clear goal for each series, and each patch has a
>> unique purpose. Then wait for reviews, and iterate from here.
> 
> I have learned much, I need more information or discussion about thow to
> avoid calling target_info() in class_init. You suggest me to use is_available
> but I still did not get it, because for multi-target binary, the is_available
> will not be called. so adding more things into is_available is
> useless(for my target).
> So I want a more clean explanation of how to do that. (I have already
> tried rename/duplicate
> the QOM name with is_available, too much changes and cumbersome)
>

First step is to create distinct duplicated types for every QOM type
concerned (like two cpu max, one for arm, one for aarch64), and select
the right one with is_available.

Once we have all types correctly duplicated, and using is_available
everywhere, we can replace the callback approach with a declarative
approach (.targets), and register types in distinct buckets.
Then we can have an automatic naming convention "arch-type" which hits
this bucket, or "type" which must exist uniquely among all buckets.

Yes it's a big change, and it can be done in parallel to current effort
to support multiple targets linked together, it's unrelated.

Please note that the bucket idea is just an idea at this point, and I'm
not sure if this will be accepted. In all cases, the refactoring for
using is_available and have duplicated first is needed first, so lets
focus on that.

Regards,
Pierrick

